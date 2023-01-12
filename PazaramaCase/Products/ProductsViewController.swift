//
//  ProductsViewController.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

protocol ProductsDisplayLogic: AnyObject {
    func displayProducts(viewModel: Products.ViewModel)
    func presentError(message: String)

}

final class ProductsViewController: UIViewController {
    weak var interactor: ProductsBusinessLogic?
    var router: (ProductsRoutingLogic & ProductsDataPassing)?
    var viewModel : Products.ViewModel?
    var searchBarOldText : String = ""
    var basketProducts : [Product] = [] {
        didSet{
            if basketProducts.count == 0 {
                badgeView.isHidden = true
            } else {
                badgeView.isHidden = false
            }
            
        }
    }
    private lazy var logoImageView : UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "logo")
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var addBasketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "shopIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(clickedBasked), for: .touchUpInside)
        return button
    }()
    
    private lazy var badgeView : UIView = {
        let badgeView = UIView()
        badgeView.backgroundColor = .red.withAlphaComponent(0.5)
        badgeView.isHidden = true
        return badgeView
    }()
    
    private lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.tintColor = UIColor(red: 0.543, green: 0.543, blue: 0.579, alpha: 1)
        searchBar.searchTextField.font = .systemFont(ofSize: 12, weight: .regular)
        searchBar.placeholder = "Marka, ürün ya da hizmet arayın"
        searchBar.image(for: .search, state: .normal)
        searchBar.layer.cornerRadius = 6
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.delegate = self
        return searchBar
    }()
    
    
    private lazy var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.cellId)
        return cv
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ProductsInteractor()
        let presenter = ProductsPresenter()
        let router = ProductsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        interactor?.getProducts(Products.Request())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureUI(){
        view.addSubview(collectionView)
        view.addSubview(logoImageView)
        view.addSubview(addBasketButton)
        view.addSubview(badgeView)
        view.addSubview(searchBar)
        
        logoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(UIView.HEIGHT * 0.04)
            make.width.equalTo(UIView.WIDTH * 0.5)
            make.centerY.equalTo(addBasketButton.snp.centerY)
        }
        
        addBasketButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIView.STATUSHeight + 16)
            make.trailing.equalToSuperview().inset(32)
            make.size.equalTo(22)
        }
        
        badgeView.snp.makeConstraints { make in
            make.top.equalTo(addBasketButton.snp.top).offset(-12)
            make.leading.equalTo(addBasketButton.snp.trailing)
            make.size.equalTo(16)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(UIView.HEIGHT * 0.05)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.layer.cornerRadius = 6
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        badgeView.layer.cornerRadius = badgeView.frame.height / 2
    }
    
    @objc private func clickedBasked(){
        router?.routeToBasket()
    }
}

extension ProductsViewController : ProductsDisplayLogic {
    func presentError(message: String) {
        DispatchQueue.main.async {
            self.showToast(message: message)
        }
    }
    
    func displayProducts(viewModel: Products.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ProductsViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.cellId, for: indexPath) as? ProductCell else {return UICollectionViewCell()}
        cell.delegate = self
        if let product = viewModel?.products[indexPath.row] {
            cell.configureCell(product)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let product = viewModel?.products[indexPath.row] {
            self.router?.routeToDetails(product: product, basketProducts: basketProducts)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 2) - 6, height: UIView.HEIGHT * 0.4385)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

extension ProductsViewController : ProductBasketDelegate {
    func addToBasket(product: Product) {
        if basketProducts.count == 0 {
            self.basketProducts.append(product)
        } else {
            if !basketProducts.contains(where: { $0.productID == product.productID}){
                self.basketProducts.append(product)
            } else {
                DispatchQueue.main.async {
                    self.showToast(message: "Ürün zaten ekli", duration: 1)
                }
            }
        }
        
    }
}

extension ProductsViewController : UISearchBarDelegate {
    
    fileprivate func configureCancelSearch(isEditing:Bool=false) {
        if let products = viewModel?.searchingModels {
            self.viewModel?.products = products
            if !isEditing {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    fileprivate func configureSearching(_ searchText: String, isPressBackSpace:Bool = false) {
        if isPressBackSpace {
            self.configureCancelSearch(isEditing: true)
        }
        guard let product = viewModel?.products else {return}
        let requestWorkItem = DispatchWorkItem {
            self.viewModel?.products = product.filter{$0.brand!.lowercased().contains(searchText)}
            self.collectionView.reloadData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250), execute: requestWorkItem)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            if searchBarOldText.count > searchText.count {
                self.configureSearching(searchText.lowercased(), isPressBackSpace: true)
            } else {
                searchBarOldText = searchText
                self.configureSearching(searchText.lowercased())
            }
        } else if searchText.count == 0 {
            searchBar.showsCancelButton = false
            configureCancelSearch()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBarOldText = searchBar.text ?? ""
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        configureCancelSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        if searchBar.text?.count ?? 1 > 0 {
            self.configureSearching((searchBar.text?.lowercased())!)
        }
    }
}

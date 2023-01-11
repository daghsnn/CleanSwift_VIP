//
//  ProductDetailViewController.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

protocol ProductDetailDisplayLogic: AnyObject {
    func displaySomething(viewModel: ProductDetail.Something.ViewModel)
}

final class ProductDetailViewController: UIViewController {
    var interactor: ProductDetailBusinessLogic?
    var router: (ProductDetailRoutingLogic & ProductDetailDataPassing)?
    var product : Product?
    weak var delegate : ProductBasketDelegate?

    private lazy var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(ProductDetailCell.self, forCellWithReuseIdentifier: ProductDetailCell.cellId)
        return cv
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(clickedBack), for: .touchUpInside)
        return button
    }()
    
    private lazy var addBasketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "shopIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(clickedBasked), for: .touchUpInside)
        return button
    }()
    
    private lazy var mainLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var constantLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Ürün Açıklaması"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    private lazy var productTextView : UITextView = {
        let text = UITextView()
        text.textColor = .black
        text.font = .systemFont(ofSize: 12, weight: .regular)
        text.textAlignment = .center
        text.backgroundColor = .clear
        return text
    }()
    
    private lazy var lineView : UIView = {
        let view = UIView()
        view.backgroundColor = ColorsManager.lineColor
        return view
    }()
    
    private lazy var lineView2 : UIView = {
        let view = UIView()
        view.backgroundColor = ColorsManager.lineColor
        return view
    }()
    
    private lazy var constantDescriptionLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Ürün Özellikleri"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    private lazy var stackView : UIStackView = {
        let stackV = UIStackView()
        stackV.backgroundColor = .clear
        stackV.axis = .vertical
        stackV.distribution = .fillEqually
        stackV.spacing = 8
        return stackV
    }()
    
    private lazy var stackView2 : UIStackView = {
        let stackV = UIStackView()
        stackV.backgroundColor = .clear
        stackV.axis = .horizontal
        stackV.distribution = .fill
        return stackV
    }()
    
    private lazy var patterLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Kalıp"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var patterDisplayLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    
    private lazy var stackView3 : UIStackView = {
        let stackV = UIStackView()
        stackV.backgroundColor = .clear
        stackV.axis = .horizontal
        stackV.distribution = .fill
        return stackV
    }()
    
    private lazy var typeLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Ürün Tipi"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var typeDisplayLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var stackView4 : UIStackView = {
        let stackV = UIStackView()
        stackV.backgroundColor = .clear
        stackV.axis = .horizontal
        stackV.distribution = .fill
        return stackV
    }()
    
    private lazy var categoryLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Ürün Kategorisi"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var categoryDisplayLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var priceLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sepete Ekle", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 0.004, green: 0.216, blue: 0.953, alpha: 1)
        button.contentMode = .center
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(clickedBasked), for: .touchUpInside)
        return button
    }()
    
    private lazy var lineView3 : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
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
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter()
        let router = ProductDetailRouter()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureDisplay()
    }
    
    private func configureUI(){
        view.addSubview(collectionView)
        view.addSubview(backButton)
        view.addSubview(addBasketButton)
        view.addSubview(mainLabel)
        view.addSubview(constantLabel)
        view.addSubview(productTextView)
        view.addSubview(lineView)
        view.addSubview(lineView2)
        view.addSubview(constantDescriptionLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(stackView2)
        stackView.addArrangedSubview(stackView3)
        stackView.addArrangedSubview(stackView4)
        stackView2.addArrangedSubview(patterLabel)
        stackView2.addArrangedSubview(patterDisplayLabel)
        stackView3.addArrangedSubview(typeLabel)
        stackView3.addArrangedSubview(typeDisplayLabel)
        stackView4.addArrangedSubview(categoryLabel)
        stackView4.addArrangedSubview(categoryDisplayLabel)
        view.addSubview(lineView3)
        view.addSubview(addButton)
        view.addSubview(priceLabel)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIView.STATUSHeight)
            make.height.equalToSuperview().multipliedBy(0.475)
            make.leading.trailing.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.top.equalTo(collectionView.snp.top).offset(32)
            make.height.equalTo(12)
            make.width.equalTo(6)
        }
        
        addBasketButton.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.trailing.equalToSuperview().inset(12)
            make.size.equalTo(22)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).offset(32)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        constantLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(lineView.snp.top).offset(24)
        }
        
        productTextView.snp.makeConstraints { make in
            make.top.equalTo(constantLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        lineView2.snp.makeConstraints { make in
            make.top.equalTo(productTextView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        constantDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(lineView2.snp.top).offset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(constantDescriptionLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(UIView.HEIGHT * 0.08)
        }
        
        lineView3.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(6)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(lineView3.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(42)
            make.width.equalTo(178)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalTo(addButton.snp.centerY)
        }
    }

    private func configureDisplay(){
        guard let product else {return}
        let attributedText = NSMutableAttributedString(string: product.brand.isOptional(), attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .heavy)])
        attributedText.append(NSMutableAttributedString(string: " " + product.itemDescription.isOptional(), attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .regular)]))
        mainLabel.attributedText = attributedText
        productTextView.text = product.longDescription
        patterDisplayLabel.text = product.pattern
        typeDisplayLabel.text = product.itemDescription
        categoryDisplayLabel.text = product.itemType
        if let price = product.price {
            let stringPrice = String(format: "%.2f", price)
            let mainPrice = stringPrice.components(separatedBy: ".")
            let priceAttributedText = NSMutableAttributedString(string: mainPrice.first.isOptional(), attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .bold)])
            priceAttributedText.append(NSMutableAttributedString(string: "." + mainPrice.last.isOptional(), attributes: [.font: UIFont.systemFont(ofSize: 11, weight: .regular)]))
            self.priceLabel.attributedText = priceAttributedText
        }
    }
    
    @objc func clickedBack(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func clickedBasked(){
        if let product {
            self.delegate?.addToBasket(product: product)
            navigationController?.popViewController(animated: true)
        }
    }
}

extension ProductDetailViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailCell.cellId, for: indexPath) as? ProductDetailCell else {return UICollectionViewCell()}
        if indexPath.row == 0 {
            if let urlString = product?.images?.imageFirst, let url = URL(string: urlString) {
                cell.configureImage(url)
            }
        } else {
            if let urlString = product?.images?.imageSecond, let url = URL(string: urlString) {
                cell.configureImage(url)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }

    
}
extension ProductDetailViewController : ProductDetailDisplayLogic {
    func displaySomething(viewModel: ProductDetail.Something.ViewModel) {
        
    }
}

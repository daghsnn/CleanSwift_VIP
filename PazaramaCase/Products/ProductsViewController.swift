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
    
    // MARK: Object lifecycle
    
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
        interactor?.getProducts(Products.Request())
    }
    
    
}

extension ProductsViewController : ProductsDisplayLogic {
    func presentError(message: String) {
        DispatchQueue.main.async {
            self.showToast(message: message)
        }
    }
    
    func displayProducts(viewModel: Products.ViewModel) {
        // TODO: buraya kadar tamamdır
        print(viewModel.products.first?.itemColor)
    }
}

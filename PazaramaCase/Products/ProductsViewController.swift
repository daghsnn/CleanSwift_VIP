//
//  ProductsViewController.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

protocol ProductsDisplayLogic: AnyObject {
    func displaySomething(viewModel: Products.Something.ViewModel)
}

final class ProductsViewController: UIViewController {
    var interactor: ProductsBusinessLogic?
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
        doSomething()
    }
    
    // MARK: Do something
        
    func doSomething() {
        let request = Products.Something.Request()
        interactor?.doSomething(request: request)
    }
    
}

extension ProductsViewController : ProductsDisplayLogic {
    func displaySomething(viewModel: Products.Something.ViewModel) {
        
    }
}

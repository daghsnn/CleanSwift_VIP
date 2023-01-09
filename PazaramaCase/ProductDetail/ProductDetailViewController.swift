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
        doSomething()
    }
    
    // MARK: Do something
        
    func doSomething() {
        let request = ProductDetail.Something.Request()
        interactor?.doSomething(request: request)
    }
    
}

extension ProductDetailViewController : ProductDetailDisplayLogic {
    func displaySomething(viewModel: ProductDetail.Something.ViewModel) {
        
    }
}

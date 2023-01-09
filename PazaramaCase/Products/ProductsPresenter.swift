//
//  ProductsPresenter.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

protocol ProductsPresentationLogic : AnyObject {
    func presentSomething(response: Products.Something.Response)
}

final class ProductsPresenter: ProductsPresentationLogic {
    weak var viewController: ProductsDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Products.Something.Response) {
        let viewModel = Products.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}

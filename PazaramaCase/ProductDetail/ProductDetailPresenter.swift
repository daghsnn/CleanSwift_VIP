//
//  ProductDetailPresenter.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

protocol ProductDetailPresentationLogic : AnyObject {
    func presentSomething(response: ProductDetail.Something.Response)
}

final class ProductDetailPresenter: ProductDetailPresentationLogic {
    weak var viewController: ProductDetailDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: ProductDetail.Something.Response) {
        let viewModel = ProductDetail.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}

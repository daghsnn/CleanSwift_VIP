//
//  ProductDetailInteractor.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol ProductDetailBusinessLogic {
    func doSomething(request: ProductDetail.Something.Request)
}

protocol ProductDetailDataStore {
    //var name: String { get set }
}

final class ProductDetailInteractor: ProductDetailBusinessLogic, ProductDetailDataStore {
    var presenter: ProductDetailPresentationLogic?
    var worker: ProductDetailWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: ProductDetail.Something.Request) {
        worker = ProductDetailWorker()
        worker?.doSomeWork()
        
        let response = ProductDetail.Something.Response()
        presenter?.presentSomething(response: response)
    }
}

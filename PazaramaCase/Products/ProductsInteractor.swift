//
//  ProductsInteractor.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol ProductsBusinessLogic {
    func doSomething(request: Products.Something.Request)
}

protocol ProductsDataStore {
    //var name: String { get set }
}

final class ProductsInteractor: ProductsBusinessLogic, ProductsDataStore {
    var presenter: ProductsPresentationLogic?
    var worker: ProductsWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Products.Something.Request) {
        worker = ProductsWorker()
        worker?.doSomeWork()
        
        let response = Products.Something.Response()
        presenter?.presentSomething(response: response)
    }
}

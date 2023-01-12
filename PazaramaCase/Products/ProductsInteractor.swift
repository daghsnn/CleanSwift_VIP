//
//  ProductsInteractor.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol ProductsBusinessLogic : AnyObject {
    func getProducts(_ request: Products.Request)
}

protocol ProductsDataStore {
// DataStore kullanılarak diğer modüllerle basket gibi ürünler paslanabilir fakat şuanki case de pek gerekli görmedim.
    
}

final class ProductsInteractor: ProductsBusinessLogic, ProductsDataStore {
    var basketProducts: [Products]?
    var presenter: ProductsPresentationLogic?
    var worker: ProductsWorker?
    
    func getProducts(_ request: Products.Request) {
        worker = ProductsWorker()
        worker?.getProducts { dictionary in
            if !dictionary.isEmpty {
                self.presenter?.presentProducts(response: Products.Response(products: dictionary))
            } else {
                self.presenter?.presentError(message: "Firebaseten verileri çekerken bi hata meydana geldi")
            }
        }
    }
}

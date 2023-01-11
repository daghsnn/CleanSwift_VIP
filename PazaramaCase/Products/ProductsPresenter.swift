//
//  ProductsPresenter.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

protocol ProductsPresentationLogic : AnyObject {
    func presentProducts(response: Products.Response)
    func presentError(message: String)
}

final class ProductsPresenter: ProductsPresentationLogic {

    weak var viewController: ProductsDisplayLogic?
    
    private func generateViewModel(_ dict : [String:Any]) -> (product:[Product], error:String?) {
        var products : [Product] = []
        for key in dict.keys {
            if let element = dict[key] {
                guard let data = try? JSONSerialization.data(withJSONObject: element, options: [.prettyPrinted]) else {
                    return (products, "Hata meydana geldi")
                }
                do {
                    products.append(try JSONDecoder().decode(Product.self, from: data))
                } catch let error {
                    return (products, error.localizedDescription)
                }

            }
        }
        
        return (products.sorted { $0.productID! < $1.productID! }, nil)
    }
    
    func presentProducts(response: Products.Response) {
        let models = generateViewModel(response.products)
        if models.error != nil {
            self.presentError(message: models.error!)
        } else {
            self.viewController?.displayProducts(viewModel: Products.ViewModel(products: models.product, searchingModels: models.product))
        }
    }
    
    func presentError(message: String) {
        viewController?.presentError(message: message)
    }
    
}

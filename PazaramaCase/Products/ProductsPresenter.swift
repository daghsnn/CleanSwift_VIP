//
//  ProductsPresenter.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

protocol ProductsPresentationLogic : AnyObject {
    func presentSomething(response: Products.Response)
    func presentError(message: String)
}

final class ProductsPresenter: ProductsPresentationLogic {

    weak var viewController: ProductsDisplayLogic?
    
    private func generateViewModel(_ dict : [String:Any]) -> [Product] {
        var products : [Product] = []
        for key in dict.keys {
            if let element = dict[key] {
                guard let data = try? JSONSerialization.data(withJSONObject: element, options: [.prettyPrinted]) else {
                    return products
                }
                do {
                    products.append(try JSONDecoder().decode(Product.self, from: data))
                } catch let error {
                    
                }

            }
        }
   
        return products
    }
    
    func presentSomething(response: Products.Response) {
        viewController?.displaySomething(viewModel: Products.ViewModel(products: generateViewModel(response.products)))
    }
    
    func presentError(message: String) {
        viewController?.presentError(message: message)
    }
    
}

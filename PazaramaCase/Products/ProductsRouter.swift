//
//  ProductsRouter.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductsRoutingLogic {
    func routeToDetails(product:Product, basketProducts: [Product])
    func routeToBasket()
}

protocol ProductsDataPassing {
    var dataStore: ProductsDataStore? { get }
}

final class ProductsRouter: NSObject, ProductsRoutingLogic, ProductsDataPassing {
    weak var viewController: ProductsViewController?
    var dataStore: ProductsDataStore?
    
    func routeToDetails(product:Product, basketProducts: [Product]) {
        let vc = ProductDetailViewController()
        vc.delegate = viewController
        vc.product = product
        vc.basketProducts = basketProducts
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToBasket() {
        let destination = BasketViewController()
        destination.products = viewController?.basketProducts
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}

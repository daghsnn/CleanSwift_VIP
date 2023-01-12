//
//  ProductDetailRouter.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailRoutingLogic {
    func routeToBasket()
}


final class ProductDetailRouter: NSObject, ProductDetailRoutingLogic {
    weak var viewController: ProductDetailViewController?
    
    func routeToBasket(){
        let destination = BasketViewController()
        destination.products = viewController?.basketProducts
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}

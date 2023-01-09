//
//  ProductDetailRouter.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailRoutingLogic {
    //func routeToSomewhere()
}

protocol ProductDetailDataPassing {
    var dataStore: ProductDetailDataStore? { get }
}

final class ProductDetailRouter: NSObject, ProductDetailRoutingLogic, ProductDetailDataPassing {
    weak var viewController: ProductDetailViewController?
    var dataStore: ProductDetailDataStore?
    
    
    // MARK: Navigation
    
    //func routeToSomewhere() {

    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: ProductDetailDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}

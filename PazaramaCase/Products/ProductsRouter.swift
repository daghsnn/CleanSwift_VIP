//
//  ProductsRouter.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductsRoutingLogic {
    //func routeToSomewhere()
}

protocol ProductsDataPassing {
    var dataStore: ProductsDataStore? { get }
}

final class ProductsRouter: NSObject, ProductsRoutingLogic, ProductsDataPassing {
    weak var viewController: ProductsViewController?
    var dataStore: ProductsDataStore?
    
    
    // MARK: Navigation
    
    //func routeToSomewhere() {

    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: ProductsDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}

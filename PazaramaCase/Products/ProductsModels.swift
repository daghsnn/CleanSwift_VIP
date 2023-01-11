//
//  ProductsModels.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

enum Products {
    struct Request {
        
    }
    struct Response {
        let products : [String:Any]
    }
    struct ViewModel {
        var products : [Product]
        var searchingModels : [Product]
    }
}

// MARK: - Product
struct Product: Codable {
    let brand: String?
    let images: Images?
    let itemColor, itemDescription, longDescription, pattern: String?
    let price: Double?
    let itemType: String?
    let productID: Int?
}

// MARK: - Images
struct Images: Codable {
    let imageFirst, imageSecond: String?
}

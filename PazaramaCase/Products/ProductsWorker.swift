//
//  ProductsWorker.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class ProductsWorker {
    func getProducts(_ completion: @escaping ([String:Any]) -> ())  {
        Database.database(url: Constants.REALTIME_URL).reference(withPath: Constants.PRODUCTS).observe(.value, with: { [weak self] snapshot in
            if let dict = snapshot.value as? [String:Any] {
                completion(dict)
            }
        })
    }
}

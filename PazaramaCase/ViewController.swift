//
//  ViewController.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    var products : [Product] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database(url: Constants.REALTIME_URL).reference(withPath: Constants.PRODUCTS)
        ref.observe(.value, with: { snapshot in
            let dict = snapshot.value as! [String:Any]
//            for (key, value) in dict.first!.enumerated() {
//                if let product = value.key as? Product {
//                    self?.products.append(product)
//                }
//            }
        })
    }


}


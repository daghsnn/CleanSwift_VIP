//
//  ViewController.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rootRef = Database.database().reference()
        rootRef.observe(.value, with: { snapshot in
          print(snapshot.value)
        })
    }


}


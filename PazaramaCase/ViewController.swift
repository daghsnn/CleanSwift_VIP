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
        let rootRef = Database.database(url: "https://pazaramacasestudy-25225-default-rtdb.europe-west1.firebasedatabase.app/").reference()
        rootRef.observe(.value, with: { snapshot in
          print(snapshot.value)
        })
    }


}


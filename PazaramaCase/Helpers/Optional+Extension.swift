//
//  Optional+Extension.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 10.01.2023.
//

import Foundation

extension Optional where Wrapped == String {
    func isOptional() -> String {
        return self ?? ""
    }
}

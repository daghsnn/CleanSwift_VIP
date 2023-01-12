//
//  ColorManager.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//
import UIKit

extension ColorsManager {
    
    enum ColorName: String {
        case cellBordorColor
        case lineColor
        case cvBorderColor
        case lineShadow
    }
    
    static func findColor(name: ColorName) -> UIColor {
        guard let color = UIColor(named: name.rawValue) else {
            return .clear
        }
        return color
    }
}

enum ColorsManager {
    static let cellBordorColor = findColor(name: ColorName.cellBordorColor)
    static let lineColor = findColor(name: ColorName.lineColor)
    static let cvBorderColor = findColor(name: ColorName.cvBorderColor)
    static let lineShadow = findColor(name: ColorName.lineShadow)
}

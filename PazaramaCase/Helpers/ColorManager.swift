//
//  ColorManager.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//
import UIKit

extension ColorsManager {
    
    enum ColorName: String {
        case bgColor
        case bgLinearBottomColor
        case bgLinearTopColor
        case greenwish
        case bluenwish
        case bgTabbarfirst
        case bgTabbarSecond
        case tabBarSelectedShadowColor
        case tabOutCircle1
        case tabOutCircle2
        case tabBarinnerFill
        case messageFirstColor
        case messageSecond
        case cvBgColor
        case cellTextColor
        case cellLineColor
        case redWish
        case editBgColor
        case navTintColor
    }
    
    static func findColor(name: ColorName) -> UIColor {
        guard let color = UIColor(named: name.rawValue) else {
            return .clear
        }
        return color
    }
}

enum ColorsManager {
    static let bgColor = findColor(name: ColorName.bgColor)
    static let bgLinearBottomColor = findColor(name: ColorName.bgLinearBottomColor)
    static let bgLinearTopColor = findColor(name: ColorName.bgLinearTopColor)
    static let greenwish = findColor(name: ColorName.greenwish)
    static let bluenwish = findColor(name: ColorName.bluenwish)
    static let bgTabbarSecond = findColor(name: ColorName.bgTabbarSecond)
    static let bgTabbarfirst = findColor(name: ColorName.bgTabbarfirst)
    static let tabBarSelectedShadowColor = findColor(name: ColorName.tabBarSelectedShadowColor)
    static let tabOutCircle1 = findColor(name: ColorName.tabOutCircle1)
    static let tabOutCircle2 = findColor(name: ColorName.tabOutCircle2)
    static let tabBarinnerFill = findColor(name: ColorName.tabBarinnerFill)
    static let messageFirstColor = findColor(name: ColorName.messageFirstColor)
    static let messageSecond = findColor(name: ColorName.messageSecond)
    static let cvBgColor = findColor(name: ColorName.cvBgColor)
    static let cellTextColor = findColor(name: ColorName.cellTextColor)
    static let cellLineColor = findColor(name: ColorName.cellLineColor)
    static let redWish = findColor(name: ColorName.redWish)
    static let editBgColor = findColor(name: ColorName.editBgColor)
    static let navTintColor = findColor(name: ColorName.navTintColor)
}

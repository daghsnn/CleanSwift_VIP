//
//  UIView+Extension.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//

import UIKit
extension UIView {
    static var BOTTOMSafeArea : CGFloat { UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0 }
    static var WIDTH: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var HEIGHT: CGFloat {
        return UIScreen.main.bounds.height
    }
}

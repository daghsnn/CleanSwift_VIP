//
//  UIView+Extension.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//

import UIKit
extension UIView {
    static var STATUSHeight : CGFloat {
        UIApplication.shared.statusBarFrame.size.height
    }

    static var WIDTH: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var HEIGHT: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    func makeShadow(color: UIColor, offSet:CGSize, blur:CGFloat, opacity:Float, spread: CGFloat = 0){
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offSet
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius  = blur / UIScreen.main.scale
        self.layer.masksToBounds = false
    }

}

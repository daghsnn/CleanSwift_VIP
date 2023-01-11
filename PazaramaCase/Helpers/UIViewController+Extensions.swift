//
//  UIViewController+Extensions.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 9.01.2023.
//

import UIKit
extension UIViewController {
    func showToast(message : String, duration: Double = 2.0) {
        let messageView = UIView(frame: CGRect(x: view.center.x, y: view.center.y, width: UIView.WIDTH * 0.63, height: UIView.HEIGHT * 0.1))
        messageView.alpha = 1
        messageView.tag = 3
        messageView.layer.cornerRadius = 10
        messageView.clipsToBounds = true
        messageView.backgroundColor = .black.withAlphaComponent(0.6)
        let toastLabel = UILabel()
        toastLabel.textColor = .white
        toastLabel.font = .systemFont(ofSize: 18)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.numberOfLines = 2
        toastLabel.sizeToFit()
        self.view.addSubview(messageView)
        messageView.addSubview(toastLabel)
        messageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(UIView.WIDTH * 0.1846)
            make.height.equalTo(UIView.HEIGHT * 0.1)
        }
        
        toastLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
        }
        
        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            messageView.removeFromSuperview()
        })
    }

}

//
//  ProductDetailCell.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 11.01.2023.
//

import UIKit
import SDWebImage

final class ProductDetailCell: UICollectionViewCell {
    static let cellId:String = "ProductDetailCell"
        
    private lazy var imageView : UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureImage(_ url:URL){
        imageView.sd_setImage(with: url)
    }
}


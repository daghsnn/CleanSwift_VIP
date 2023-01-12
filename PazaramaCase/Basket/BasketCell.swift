//
//  BasketCell.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 12.01.2023.
//

import UIKit
import SDWebImage


final class BasketCell: UICollectionViewCell {
    static let cellId:String = "BasketCell"
    
    var product : Product?
    
    private lazy var lineView : UIView = {
        let view = UIView()
        view.backgroundColor = ColorsManager.lineColor
        return view
    }()
    
    private lazy var imageView : UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var infoLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.textAlignment = .natural
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var priceLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(lineView)
        addSubview(imageView)
        addSubview(infoLabel)
        addSubview(priceLabel)

        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(8)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(16)
            make.size.equalTo(82)
            make.leading.equalToSuperview().inset(16)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(16)
            make.leading.equalTo(imageView.snp.trailing).offset(16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(8)
            make.leading.equalTo(infoLabel.snp.leading)
        }
        
    }
    
    func configureCell(_ product: Product ){
        imageView.sd_setImage(with: URL(string: (product.images?.imageFirst!)!)!)
        let attributedText = NSMutableAttributedString(string: product.brand.isOptional(), attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .heavy)])
        attributedText.append(NSMutableAttributedString(string: " " + product.itemDescription.isOptional(), attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .regular)]))
        infoLabel.attributedText = attributedText
        if let price = product.price {
            let stringPrice = String(format: "%.2f", price)
            let mainPrice = stringPrice.components(separatedBy: ".")
            let priceAttributedText = NSMutableAttributedString(string: mainPrice.first.isOptional(), attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .bold)])
            priceAttributedText.append(NSMutableAttributedString(string: "." + mainPrice.last.isOptional(), attributes: [.font: UIFont.systemFont(ofSize: 11, weight: .regular)]))
            self.priceLabel.attributedText = priceAttributedText
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayer()
    }
    
    fileprivate func configureLayer() {
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 6
        layer.borderColor = ColorsManager.cellBordorColor.cgColor
        layer.borderWidth = 1
        imageView.clipsToBounds = true
    }
}

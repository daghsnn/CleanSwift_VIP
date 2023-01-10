//
//  ProductCell.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 10.01.2023.
//

import UIKit
import SDWebImage

protocol ProductBasketDelegate : AnyObject {
    func addToBasket(product:Product)
}

final class ProductCell: UICollectionViewCell {
    static let cellId:String = "ProductCell"
    
    var product : Product?
    weak var delegate : ProductBasketDelegate?
    
    private lazy var imageView : UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
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
        label.textAlignment = .natural
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        label.attributedText = NSMutableAttributedString(string: "9.824", attributes: [NSAttributedString.Key.kern: -0.07, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private lazy var addBasketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sepete Ekle", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 1, green: 0, blue: 0.545, alpha: 1)
        button.contentMode = .center
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(handleAddBasket), for: .touchUpInside)
        return button
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
        addSubview(imageView)
        addSubview(infoLabel)
        addSubview(priceLabel)
        addSubview(addBasketButton)

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(UIView.HEIGHT * 0.287)
            make.leading.trailing.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(16)
        }
        
        addBasketButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    func configureCell(_ product: Product ){
        self.product = product
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
        guard let urlString =  product.images?.imageFirst, let url = URL(string: urlString) else {return}
        imageView.sd_setImage(with: url)
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
    
    @objc private func handleAddBasket(){
        if let product, delegate != nil {
            self.delegate?.addToBasket(product: product)
        }
    }
}


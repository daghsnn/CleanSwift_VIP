//
//  BasketViewController.swift
//  PazaramaCase
//
//  Created by Hasan Dag on 12.01.2023.
//

import UIKit

final class BasketViewController: UIViewController {
    
    var products:[Product]?
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(clickedBack), for: .touchUpInside)
        return button
    }()
    
    private lazy var constLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Sepetim"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private lazy var productCountLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.layer.borderColor = ColorsManager.cvBorderColor.cgColor
        cv.layer.borderWidth = 1
        cv.layer.cornerRadius = 6
        cv.register(BasketCell.self, forCellWithReuseIdentifier: BasketCell.cellId)
        return cv
    }()
    
    private lazy var lineView : UIView = {
        let view = UIView()
        view.backgroundColor = ColorsManager.lineColor
        return view
    }()
    
    private lazy var upIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "upIcon")?.withRenderingMode(.alwaysOriginal))
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var priceLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sepete Onayla", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 0.004, green: 0.216, blue: 0.953, alpha: 1)
        button.contentMode = .center
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(clickedBasked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    fileprivate func configureCalculations() {
        let prices = products?.compactMap{$0.price}
        var totalPrice = 0.0
        for price in prices! {
            totalPrice += price
        }
        let stringPrice = String(format: "%.2f", totalPrice)
        let mainPrice = stringPrice.components(separatedBy: ".")
        let priceAttributedText = NSMutableAttributedString(string: mainPrice.first.isOptional(), attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .bold)])
        priceAttributedText.append(NSMutableAttributedString(string: "." + mainPrice.last.isOptional(), attributes: [.font: UIFont.systemFont(ofSize: 11, weight: .regular)]))
        self.priceLabel.attributedText = priceAttributedText
        if let count = products?.count {
            self.productCountLabel.text = "\(count) Ürün"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureCalculations()
        if products?.count == 0 {
            collectionView.isHidden = true
        } else {
            collectionView.isHidden = false
        }
        let height = (UIView.HEIGHT * 0.2) * CGFloat(products?.count ?? 0)
        collectionView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    private func configureUI(){
        view.addSubview(backButton)
        view.addSubview(constLabel)
        view.addSubview(productCountLabel)
        view.addSubview(collectionView)
        view.addSubview(lineView)
        view.addSubview(upIcon)
        view.addSubview(addButton)
        view.addSubview(priceLabel)
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(UIView
                .STATUSHeight + 32)
            make.height.equalTo(12)
            make.width.equalTo(6)
        }

        constLabel.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(16)
            make.top.equalToSuperview().inset(UIView
                .STATUSHeight + 16)
        }
        
        productCountLabel.snp.makeConstraints { make in
            make.top.equalTo(constLabel.snp.bottom).offset(2)
            make.leading.equalTo(constLabel.snp.leading)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(productCountLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(UIView.HEIGHT * 0.17)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview().inset(UIView.HEIGHT * 0.125)
        }
        
        upIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(8)
            make.top.equalTo(lineView.snp.bottom).offset(32)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(upIcon.snp.centerY)
            make.leading.equalTo(upIcon.snp.trailing).offset(8)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(42)
            make.width.equalTo(178)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.layer.borderColor = ColorsManager.cvBorderColor.cgColor
        collectionView.layer.borderWidth = 1
        collectionView.layer.cornerRadius = 6
        lineView.makeShadow(color: ColorsManager.lineColor, offSet: CGSize(width: 0, height: -6), blur: 16, opacity: 0.25)
    }
    
    @objc private func clickedBasked(){
//
        
    }
    
    @objc func clickedBack(){
        navigationController?.popViewController(animated: true)
    }
}

extension BasketViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketCell.cellId, for: indexPath) as? BasketCell else {return UICollectionViewCell()}
        if let product = products?[indexPath.row] {
            cell.configureCell(product)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}

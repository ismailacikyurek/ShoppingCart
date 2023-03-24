//
//  ProductCollectionViewCell.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 11.03.2023.
//


import UIKit
import SnapKit
import Kingfisher

protocol ProductFavoriCollectionViewProtocol: AnyObject {
    func productFavoriCollectionCell(productId: Int, fav: Bool)
}
protocol ProductRecentlyCollectionViewProtocol: AnyObject {
    func productRecentlyCollectionCell(productId: Int)
}
final class ProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProductCollectionViewCell"
    
    // MARK: UIComponent
    lazy var productImage = UIImageView()
    lazy var productTitleLabel = UILabel()
    lazy var ratingImage = UIImageView()
    lazy var ratingLabel = UILabel()
    lazy var priceLabel = UILabel()
    lazy var favButton = UIButton()
    lazy var closeButton = UIButton()
    
    weak var delegate : ProductFavoriCollectionViewProtocol?
    weak var delegateRecently : ProductRecentlyCollectionViewProtocol?
    var favButtonSelected = true
    var productId : Int?
    var callback : ((UICollectionViewCell) -> Void)?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setupUI()
        layoutUI()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func configure(data: Product,favStatus : [String:Bool])  {
        productImage.kf.setImage(with:URL(string: data.image ?? ""))
        productTitleLabel.text = data.title!
        ratingLabel.text = "\(data.rating!.rate!)/5"
        priceLabel.text = "$\(data.price!)"
        self.productId = data.id
        if favStatus.keys.contains("\(productId!)") {
            favButtonSelected = false
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favButtonSelected = true
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    func configureProducListVC(data: Product,favStatus : [String:Bool])  {
        
        productImage.kf.setImage(with:URL(string: data.image ?? ""))
        productTitleLabel.text = data.title!
        ratingLabel.text = "\(data.rating!.rate!)/5"
        priceLabel.text = "$\(data.price!)"
        self.productId = data.id
        
        if favStatus.keys.contains("\(productId!)") {
            favButtonSelected = false
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favButtonSelected = true
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        productImage.snp.updateConstraints() { make in
            make.top.equalTo(self.snp.top).offset(6)
            make.leading.equalTo(self.snp.leading).offset(23)
            make.trailing.equalTo(self.snp.trailing).offset(-23)
            make.height.equalTo(130)
        }
        
        
    }
    
    func configureRecently(data: Product)  {
        self.favButton.isHidden = true
        closeButton.isHidden = false
        productImage.kf.setImage(with:URL(string: data.image ?? ""))
        productTitleLabel.text = data.title!
        ratingLabel.text = "\(data.rating!.rate!)/5"
        priceLabel.text = "$\(data.price!)"
        self.productId = data.id
    }
}

extension ProductCollectionViewCell {
    //MARK: UI Action
    @objc func favButtonTapped() {
        self.callback?(self)
        if self.favButtonSelected == false {
            favButtonSelected = true
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            delegate?.productFavoriCollectionCell(productId: productId!, fav: false)
        } else {
            favButtonSelected = false
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            delegate?.productFavoriCollectionCell(productId: productId!, fav: true)
        }
    }
    @objc func closeButtonTapped() {
        self.callback?(self)
        self.delegateRecently?.productRecentlyCollectionCell(productId: productId!)
    }
    
}


//MARK: AddSubiew,AddTarget,LayoutUI,SetupUI

extension ProductCollectionViewCell : GeneralViewProtocol {
    func addTarget() {
        favButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor.mainAppColor.cgColor
        self.layer.borderWidth = 0.5
        productImage.createUIImageView(contentMode: .scaleToFill)
        productTitleLabel.createLabel(text: "", textColor: .black, font: .Regular_11, zPozisition: 1, numberOfLines: 2, textAlignment: .center)
        
        ratingLabel.createLabel(text: "", textColor: .black, font: .Bold_11, zPozisition: 1, numberOfLines: 1, textAlignment: .left)
        
        ratingImage.createUIImageView(tintColor: .mainAppColor,contentMode: .scaleToFill)
        ratingImage.image = UIImage(systemName: "star.leadinghalf.filled")
        priceLabel.createLabel(text: "",textColor: .black,font: .Bold_15, numberOfLines: 1, textAlignment: .right)
        
        favButton.createButton(titleColor: .orange,zPozisition: 3)
        favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        
        closeButton.createButton(image: "closeButton",zPozisition: 3)
        closeButton.isHidden = true
    }
    
    
    func layoutUI() {
        productImageConstraints()
        productTitleLabelConstraints()
        priceLabelConstraints()
        ratingLabelConstraints()
        ratingImageConstraints()
        favButtonConstraints()
        closeButtonConstraints()
    }
    
    func addView() {
        addSubviews(productImage,productTitleLabel,priceLabel,ratingImage,ratingLabel,favButton,closeButton)
    }
    
    
}

//MARK: Constraints
extension ProductCollectionViewCell {
    private func productImageConstraints() {
        productImage.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(6)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.height.equalTo(110)
        }
    }
    
    private func productTitleLabelConstraints() {
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(0)
            make.leading.equalTo(productImage.snp.leading).offset(-8)
            make.trailing.equalTo(productImage.snp.trailing).offset(8)
            make.height.equalTo(40)
        }
    }
    
    private func priceLabelConstraints() {
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-6)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.height.equalTo(20)
        }
    }
    
    private func ratingLabelConstraints() {
        ratingLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.trailing.equalTo(productTitleLabel.snp.trailing).offset(-3)
            make.height.equalTo(20)
        }
    }
    
    private func ratingImageConstraints() {
        ratingImage.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.top).offset(0)
            make.trailing.equalTo(ratingLabel.snp.leading).offset(-1)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
    
    private func favButtonConstraints() {
        favButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
    private func closeButtonConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
    }
}

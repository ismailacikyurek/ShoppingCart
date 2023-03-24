//
//  ProductDetailView.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 13.03.2023.
//

import UIKit

//MARK: Protocols
protocol ProductDetailViewInterfaceProtocol : AnyObject {
    func updateCart(productCount : Int)
    func shareButtonTapped(id:String)
    func favButtonTapped(productId : Int,fav:Bool)
    func addNewAddress()
    func backButtonTapped()
}

class ProductDetailView: UIView {
    // MARK: UIComponent
    lazy var productImageView = UIImageView()
    lazy var backButton = UIButton()
    lazy var favButton = UIButton()
    lazy var shareButton = UIButton()
    lazy var productTitleLabel = UILabel()
    lazy var productDescLabel = UILabel()
    lazy var productPriceLabel = UILabel()
    lazy var countLabel = UILabel()
    lazy var ratingCountLabel = UILabel()
    lazy var ratingImageView = UIImageView()
    lazy var downView = UIView()
    lazy var plusButton = UIButton()
    lazy var minusButton = UIButton()
    lazy var addCartButton = UIButton()
    lazy var addressTextField = UITextField()
    lazy var thePicker = UIPickerView()
    
    var count = 0
    var productPrice = 1.0
    var productId : Int?
    var fav = false
    var viewController : ProductDetailViewController?
    weak var interface : ProductDetailViewInterfaceProtocol?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        addView()
        addTarget()
        layoutUI()
        addressTextFieldThePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(data : Product?) {
        guard let data = data else {return}
        self.productImageView.kf.setImage(with:URL(string: data.image ?? ""))
        self.productTitleLabel.text = data.title
        self.productPriceLabel.text = "$\(data.price!)"
        self.productDescLabel.text = data.description
        self.ratingCountLabel.text = "(\(data.rating?.count ?? 0)) evaluation"
        self.ratingStar(rating: Int(data.rating?.rate ?? 5))
        self.productPrice = data.price!
        self.productId = data.id
    }
    func ratingStar(rating : Int) {
        switch rating {
        case 1 : self.ratingImageView.image = UIImage(named: "oneStar")
        case 2 : self.ratingImageView.image = UIImage(named: "twoStar")
        case 3 : self.ratingImageView.image = UIImage(named: "threeStar")
        case 4 : self.ratingImageView.image = UIImage(named: "fourStar")
        case 5 : self.ratingImageView.image = UIImage(named: "fiveStar")
        default: self.ratingImageView.image = UIImage(named: "fiveStar")
        }
    }
}
//MARK: AddSubiew,AddTarget,LayoutUI,SetupUI
extension ProductDetailView : GeneralViewProtocol {
    func addTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        favButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        addCartButton.addTarget(self, action: #selector(addCartButtonTapped), for: .touchUpInside)
    }
    
    func setupUI() {
        self.backgroundColor = .white
        backButton.createButton(image: "backButton",zPozisition: 2)
        shareButton.createButton(image: "Share",zPozisition: 2)
        favButton.createButton(image: "favoriteEmpty",zPozisition: 2)
        
        productImageView.createUIImageView(contentMode: .scaleToFill)
        downView.createView(backgroundColor: .white, cornerRadius: 28, shadowColor: UIColor.gray.cgColor, shadowOffset: CGSize(width: 2, height: -10))
        productTitleLabel.createLabel(textColor: UIColor.black, font: .Bold_20, numberOfLines: 2,textAlignment: .left)
        ratingImageView.createUIImageView(contentMode: .scaleToFill)
        ratingCountLabel.createLabel(textColor: UIColor.gray, font: .Regular_16)
        addCartButton.createButton(title: "Add to Cart", backgroundColor: .mainAppColor, cornerRadius: 15, zPozisition: 3)
        addCartButton.setImage(UIImage.init(systemName: "cart.fill.badge.plus"), for: .normal)
        addCartButton.tintColor = .white
        addCartButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        addCartButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        productPriceLabel.createLabel(font: .Bold_24,zPozisition: 3)
        minusButton.createButton(backgroundColor: .mainAppColor, titleColor: .white, cornerRadius: 25, zPozisition: 3)
        minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
        plusButton.createButton(backgroundColor: .mainAppColor, titleColor: .white, cornerRadius: 25, zPozisition: 3)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        minusButton.isHidden = true
        plusButton.isHidden = true
        countLabel.createLabel(text: "\(count)",textColor: UIColor.black, font: .Bold_20, zPozisition: 3, numberOfLines: 2,textAlignment: .center)
        countLabel.isHidden = true
        productDescLabel.createLabel(text: "",textColor: UIColor.black, font: .Regular_16,numberOfLines: 10,textAlignment: .justified)
        addressTextField.createTextField(placeHolder: "Please,Add address",cornerRadius: 10,borderWidth: 1,borderColor: UIColor.mainAppColor.cgColor)
        addressTextField.padding()
        addressTextField.makeDropDownForAdress()
        addressTextField.layer.zPosition = 4
        
    }
    
    func layoutUI() {
        backButtonConstraints()
        favButtonConstraints()
        shareButtonConstraints()
        productImageViewConstraints()
        downViewConstraints()
        productTitleLabelConstraints()
        ratingImageViewConstraints()
        ratingCountLabelConstraints()
        addressTextFieldConstraints()
        productDescLabelConstraints()
        productPriceLabelConstraints()
        addCartButtonConstraints()
        minusButtonConstraints()
        plusButtonConstraints()
        SAYACLABELConstraints()
    }
    
    func addView() {
        addSubviews(backButton,productImageView,downView,addCartButton,favButton,shareButton,productPriceLabel,plusButton,minusButton,countLabel,addressTextField)
        downView.addSubviews(productTitleLabel,productDescLabel,ratingCountLabel,ratingImageView)
    }
    
    
}
extension ProductDetailView {
    //MARK: UI Action
    @objc func backButtonTapped() {
        interface?.backButtonTapped()
    }
    @objc func favButtonTapped() {
        interface?.favButtonTapped(productId: self.productId!, fav: !fav)
    }
    @objc func shareButtonTapped() {
        interface?.shareButtonTapped(id:"\(productId!)")
    }
    
    @objc func addCartButtonTapped() {
        if addressTextField.text == "" {
            GeneralPopup.showPopup(vc: self.viewController!, image: .error, title: "Error", subtitle: "Please select an address", buttonText: "Ok")
        } else {
            self.count = 1
            interface?.updateCart(productCount: count)
            
        }
    }
    
    @objc func minusButtonTapped() {
        self.count -= 1
        interface?.updateCart(productCount: count)
    }
    
    @objc func plusButtonTapped() {
        if count == 5 {
            GeneralPopup.showPopup(vc: self.viewController!, image: .error, title: "Error", subtitle: "You can add up to 5 products", buttonText: "Ok")
        } else {
            self.count += 1
            interface?.updateCart(productCount: count)
        }
        
    }
    
    @objc func addNewAddressButton() {
        self.endEditing(true)
        interface?.addNewAddress()
    }
    @objc func cancelPicker() {
        self.endEditing(true)
    }
}
extension ProductDetailView  {
    func updateProductPriceLabel(count : Int) {
        let price = productPrice * Double(count)
        self.productPriceLabel.text = "$\(price.rounded(digits: 2))"
    }
    func updateCountLabel(count : Int) {
        self.countLabel.text = "\(count)"
        updateProductPriceLabel(count: count)
        if count < 1 {
            addCartButton.isHidden = false
            minusButton.isHidden = true
            plusButton.isHidden = true
            countLabel.isHidden = true
            updateProductPriceLabel(count: 1)
        } else {
            
            addCartButton.isHidden = true
            minusButton.isHidden = false
            plusButton.isHidden = false
            countLabel.isHidden = false
        }
    }
    
    func addressTextFieldThePicker() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Add New Address", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.addNewAddressButton))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action:  #selector(self.cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.addressTextField.inputAccessoryView = toolBar
        addressTextField.inputView = thePicker
    }
}

//MARK: Constraints
extension ProductDetailView {
    func backButtonConstraints() {
        self.backButton.snp.makeConstraints { make in
            make.top.equalTo(self).offset(40)
            make.leading.equalTo(self).offset(3)
            make.height.width.equalTo(35)
        }
    }
    func favButtonConstraints() {
        self.favButton.snp.makeConstraints { make in
            make.top.equalTo(backButton).offset(0)
            make.trailing.equalTo(self).offset(-20)
            make.height.width.equalTo(35)
        }
    }
    
    func shareButtonConstraints() {
        self.shareButton.snp.makeConstraints { make in
            make.top.equalTo(backButton).offset(0)
            make.trailing.equalTo(favButton.snp.leading).offset(-20)
            make.height.width.equalTo(35)
        }
    }
    
    func productImageViewConstraints() {
        self.productImageView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(-5)
            make.leading.equalTo(self.snp.leading).offset(25)
            make.trailing.equalTo(self.snp.trailing).offset(-25)
            make.height.equalTo((ScreenSize.height/2.5)-30)
        }
        
    }
    func downViewConstraints() {
        downView.layer.zPosition = 2
        self.downView.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(-20)
            make.leading.trailing.equalTo(self).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(0)
        }
    }
    
    func productTitleLabelConstraints() {
        self.productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(downView).offset(5)
            make.leading.equalTo(downView.snp.leading).offset(5)
            make.trailing.equalTo(downView.snp.trailing).offset(-5)
            make.height.equalTo(80)
        }
        
    }
    func ratingImageViewConstraints() {
        self.ratingImageView.snp.makeConstraints { make in
            make.top.equalTo(downView).offset(90)
            make.leading.equalTo(downView.snp.leading).offset(5)
            make.height.equalTo(18)
            make.width.equalTo(120)
        }
        
    }
    func ratingCountLabelConstraints() {
        self.ratingCountLabel.snp.makeConstraints { make in
            make.top.equalTo(downView).offset(85)
            make.leading.equalTo(ratingImageView.snp.trailing).offset(5)
            make.height.equalTo(25)
            make.width.equalTo(150)
        }
    }
    
    func addressTextFieldConstraints() {
        self.addressTextField.snp.makeConstraints { make in
            make.top.equalTo(downView).offset(120)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.height.equalTo(40)
        }
    }
    func productDescLabelConstraints() {
        self.productDescLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingCountLabel.snp.bottom).offset(45)
            make.leading.equalTo(downView).offset(5)
            make.trailing.equalTo(downView).offset(-5)
            make.height.equalTo(ScreenSize.height/3.8-40)
        }
    }
    
    func addCartButtonConstraints() {
        self.addCartButton.snp.makeConstraints { make in
            make.top.equalTo(downView.snp.bottom).offset(-85)
            make.trailing.equalTo(downView).offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(160)
        }
    }
    func plusButtonConstraints() {
        self.plusButton.snp.makeConstraints { make in
            make.top.equalTo(addCartButton).offset(0)
            make.trailing.equalTo(addCartButton).offset(0)
            make.height.width.equalTo(50)
            
        }
    }
    func minusButtonConstraints() {
        self.minusButton.snp.makeConstraints { make in
            make.top.equalTo(addCartButton).offset(0)
            make.leading.equalTo(addCartButton).offset(0)
            make.height.width.equalTo(50)
            
        }
    }
    func SAYACLABELConstraints() {
        self.countLabel.snp.makeConstraints { make in
            make.top.equalTo(addCartButton).offset(0)
            make.leading.equalTo(minusButton.snp.trailing).offset(5)
            make.height.width.equalTo(50)
            
        }
    }
    func productPriceLabelConstraints() {
        self.productPriceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(downView).offset(-35)
            make.leading.equalTo(self).offset(30)
            make.width.equalTo(120)
            make.height.equalTo(50)
            
        }
    }
    
}

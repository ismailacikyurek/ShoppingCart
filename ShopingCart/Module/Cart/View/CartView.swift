//
//  CartView.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 21.03.2023.
//

import UIKit
import FirebaseAuth
import SnapKit

protocol CartViewInterfaceProtocol: AnyObject {
    func paymentButtonTapped()
    func keepShoppingButtonTapped()
}

class CartView: UIView {
    
    // MARK: - UIComponent
    lazy var cartTableView = UITableView()
    lazy var priceView = UIView()
    lazy var priceLabel = UILabel()
    lazy var paymentButton = UIButton()
    
    lazy var emptyBasketView = UIView()
    lazy var emptyBasketTitleLabel = UILabel()
    lazy var keepShoppingButton = UIButton()
    lazy var emptyBasketImageView = UIImageView()
    lazy var emptyBasketDescLabel = UILabel()
    
    private let currentUser = Auth.auth().currentUser?.displayName
    weak var interface: CartViewInterfaceProtocol?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        addView()
        addTarget()
        layoutUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: AddSubiew,AddTarget,LayoutUI,SetupUI

extension CartView : GeneralViewProtocol {
    func addTarget() {
        paymentButton.addTarget(self, action: #selector(paymentButtonTapped), for: .touchUpInside)
        keepShoppingButton.addTarget(self, action: #selector(keepShoppingButtonTapped), for: .touchUpInside)
    }
    
    func setupUI() {
        self.backgroundColor = .systemGray6
        priceView.createView(backgroundColor: .white, cornerRadius: 22, shadowColor: UIColor.gray.cgColor, shadowOffset: CGSize(width: 5, height: 5), borderColor: UIColor.mainAppColor.cgColor,borderWidth: 1)
        priceLabel.createLabel(text: "0.0", backgroundColor: .white, textColor: .mainAppColor,font: .Bold_24,textAlignment: .left)
        paymentButton.createButton(title: "Payment", backgroundColor: .mainAppColor,font: .Bold_20,cornerRadius: 12)
        emptyBasketView.createView(backgroundColor: .white,shadowColor: UIColor.white.cgColor)
        emptyBasketImageView.createUIImageView(image: UIImage.init(named: "emptyCart"),contentMode: .scaleToFill)
        emptyBasketTitleLabel.createLabel(text: "There are no items in your cart", backgroundColor: .white,font: .Bold_20,textAlignment: .center)
        emptyBasketDescLabel.createLabel(text: "Looks like you have not added nothing  to you cart. Go ahead & explore top categories", backgroundColor: .white, font: .Regular_15, numberOfLines: 3,textAlignment: .center)
        keepShoppingButton.createButton(title: "Keep Shopping",backgroundColor: .mainAppColor,font: .Bold_20,cornerRadius: 12)
        cartTableView.backgroundColor = .clear
        self.emptyBasketView.isHidden = true
        self.keepShoppingButton.isHidden = true
        
    }
    
    func layoutUI() {
        priceViewConstraints()
        cartTableViewConstraints()
        priceLabelConstraints()
        paymentButtonConstraints()
        emptyBasketViewConstraints()
        emptyBasketImageViewConstraints()
        emptyBasketTitleLabelConstraints()
        emptyBasketDescLabelConstraints()
        keepShoppingButtonConstraints()
    }
    
    func addView() {
        addSubviews(cartTableView,priceView,emptyBasketView,paymentButton,keepShoppingButton)
        priceView.addSubviews(priceLabel)
        emptyBasketView.addSubviews(emptyBasketTitleLabel,emptyBasketImageView,emptyBasketDescLabel)
    }
}

extension CartView  {
    //MARK: UI Action
    @objc func paymentButtonTapped() {
        interface?.paymentButtonTapped()
    }
    @objc func keepShoppingButtonTapped() {
        interface?.keepShoppingButtonTapped()
    }
    
    func emptyCart() {
        self.emptyBasketView.isHidden = false
        self.keepShoppingButton.isHidden = false
        self.priceView.isHidden = true
        self.cartTableView.isHidden = true
        self.paymentButton.isHidden = true
        
    }
    func fullCart() {
        self.emptyBasketView.isHidden = true
        self.keepShoppingButton.isHidden = true
        self.priceView.isHidden = false
        self.cartTableView.isHidden = false
        self.paymentButton.isHidden = false
    }
}


//MARK: Constraints
extension CartView  {
    func cartTableViewConstraints() {
        self.cartTableView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(4)
            make.leading.trailing.equalTo(self).offset(0)
            make.bottom.equalTo(priceView.snp.top).offset(10)
        }
    }
    
    func priceViewConstraints() {
        self.priceView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(tabBarSize.tabbarPozisiton(tabbarMiny: ScreenSize.height)-100)
            make.leading.trailing.equalTo(self).offset(0)
            make.height.equalTo(100)
        }
    }
    
    func priceLabelConstraints() {
        self.priceLabel.snp.makeConstraints { make in
            make.top.equalTo(priceView).offset(20)
            make.leading.equalTo(priceView).offset(20)
            make.height.equalTo(160)
            make.height.equalTo(40)
        }
    }
    func paymentButtonConstraints() {
        self.paymentButton.snp.makeConstraints { make in
            make.top.equalTo(priceView).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.width.equalTo(160)
            make.height.equalTo(40)
        }
    }
    
    func emptyBasketViewConstraints() {
        self.emptyBasketView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self).offset(0)
            make.leading.trailing.equalTo(self).offset(0)
        }
    }
    
    func emptyBasketImageViewConstraints() {
        self.emptyBasketImageView.snp.makeConstraints { make in
            make.top.equalTo(emptyBasketView).offset(180)
            make.leading.equalTo(emptyBasketView).offset(100)
            make.trailing.equalTo(emptyBasketView).offset(-100)
            make.height.equalTo(160)
        }
    }
    
    func emptyBasketTitleLabelConstraints() {
        self.emptyBasketTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyBasketImageView.snp.bottom).offset(10)
            make.leading.equalTo(emptyBasketView).offset(30)
            make.trailing.equalTo(emptyBasketView).offset(-30)
            make.height.equalTo(40)
        }
    }
    func emptyBasketDescLabelConstraints() {
        self.emptyBasketDescLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyBasketTitleLabel.snp.bottom).offset(0)
            make.leading.equalTo(emptyBasketView).offset(15)
            make.trailing.equalTo(emptyBasketView).offset(-15)
            make.height.equalTo(50)
        }
    }
    
    func keepShoppingButtonConstraints() {
        self.keepShoppingButton.snp.makeConstraints { make in
            make.top.equalTo(emptyBasketDescLabel.snp.bottom).offset(15)
            make.leading.equalTo(self).offset(70)
            make.trailing.equalTo(self).offset(-70)
            make.height.equalTo(40)
        }
    }    
}

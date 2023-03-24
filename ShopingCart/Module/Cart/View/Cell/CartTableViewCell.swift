//
//  CartTableViewCell.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 20.03.2023.

import UIKit
import Kingfisher

protocol CartTableViewCellProtocol: AnyObject {
    func closeButtonTapped(productId: Int)
    func plusButtonTapped(productId: Int,count: Int)
    func minusButtonTapped(productId: Int,count: Int)
}

class CartTableViewCell: UITableViewCell {
    static let identifier = "CartTableViewCell"
    weak var delegate : CartTableViewCellProtocol?
    var productId = 0
    var viewController : CartViewController?
    var count : Int!
    var callback : ((UITableViewCell) -> Void)?
    let mainView : UIView = {
        let x = UIView()
        x.translatesAutoresizingMaskIntoConstraints = true
        x.frame = CGRect(x: 10, y: 10, width: ScreenSize.widht-20, height: 150)
        x.backgroundColor = .white
        x.layer.cornerRadius = 13
        x.layer.shadowColor = UIColor.gray.cgColor
        x.layer.shadowOffset = CGSize(width: 3, height: 3)
        x.layer.shadowRadius = 5
        x.layer.shadowOpacity = 0.7
        return x
    }()
    let productTitlelabel : UILabel = {
        let x = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = true
        x.frame = CGRect(x: 140, y: 10, width: 205, height: 30)
        return x
    }()
    let deliveryDatelabel : UILabel = {
        let x = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = true
        x.font = .Regular_15
        x.frame = CGRect(x: 140, y: 60, width: 205, height: 20)
        return x
    }()
    let productImageView : UIImageView = {
        let x = UIImageView()
        x.translatesAutoresizingMaskIntoConstraints = true
        x.frame = CGRect(x: 15, y: 10, width: 120, height: 120)
        x.contentMode = .scaleToFill
        x.layer.cornerRadius = 13
        return x
    }()
    let deleteButton : UIButton = {
        let x = UIButton()
        x.translatesAutoresizingMaskIntoConstraints = true
        x.frame = CGRect(x: -8, y: -8, width: 25, height: 25)
        x.contentMode = .scaleToFill
        x.layer.zPosition = 2
        x.setImage(UIImage.init(named: "closeButton"), for: .normal)
        return x
    }()
    
    let plusAndMinusView : UIView = {
        let x = UIView()
        x.translatesAutoresizingMaskIntoConstraints = true
        x.frame = CGRect(x: 140, y: 100, width: 90, height: 30)
        x.layer.zPosition = 2
        x.layer.cornerRadius = 13
        x.layer.borderWidth = 0.5
        x.layer.borderColor = UIColor.gray.cgColor
        return x
    }()
    let minusButton : UIButton = {
        let x = UIButton()
        x.translatesAutoresizingMaskIntoConstraints = true
        x.frame = CGRect(x: 1, y: 1, width: 28, height: 28)
        x.contentMode = .scaleToFill
        x.layer.zPosition = 2
        x.tintColor = .mainAppColor
        x.setImage(UIImage.init(systemName: "minus"), for: .normal)
        return x
    }()
    let countLabel : UILabel = {
        let x = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = true
        x.frame = CGRect(x: 31, y: 1, width: 28, height: 28)
        x.contentMode = .scaleToFill
        x.layer.zPosition = 2
        x.textColor = .mainAppColor
        x.layer.masksToBounds = true
        x.layer.cornerRadius = 14
        x.backgroundColor = .systemGray6
        x.textAlignment = .center
        x.text = ""
        return x
    }()
    let plusButton : UIButton = {
        let x = UIButton()
        x.translatesAutoresizingMaskIntoConstraints = true
        x.frame = CGRect(x: 61, y: 1, width: 28, height: 28)
        x.contentMode = .scaleToFill
        x.layer.zPosition = 2
        x.tintColor = .mainAppColor
        x.setImage(UIImage.init(systemName: "plus"), for: .normal)
        return x
    }()
    let priceLabel : UILabel = {
        let x = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = true
        x.frame = CGRect(x: 231, y: 90, width: 120, height: 40)
        x.font = .Bold_24
        x.layer.zPosition = 2
        x.textColor = .mainAppColor
        x.textAlignment = .right
        return x
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectedBackgroundView?.backgroundColor = .clear
        addView()
        addTarget()
    }
    
    func addTarget() {
        deleteButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    func addView() {
        contentView.addSubviews(mainView)
        mainView.addSubviews(productTitlelabel,productImageView,deleteButton,plusAndMinusView,priceLabel,deliveryDatelabel)
        plusAndMinusView.addSubviews(minusButton,countLabel,plusButton)
        self.deleteButton.isHidden = false
        self.productTitlelabel.isHidden = false
        self.productImageView.isHidden = false
        self.plusAndMinusView.isHidden = false
        self.priceLabel.isHidden = false
        self.deliveryDatelabel.isHidden = false
        self.mainView.frame = CGRect(x: 10, y: 10, width: ScreenSize.widht-20, height: 150)
    }
    
    //MARK: UI Action
    @objc func closeButtonTapped() {
        self.callback?(self)
        UIView.animate(withDuration: 1, delay: 0) {
            self.deleteButton.isHidden = true
            self.productTitlelabel.isHidden = true
            self.productImageView.isHidden = true
            self.plusAndMinusView.isHidden = true
            self.priceLabel.isHidden = true
            self.deliveryDatelabel.isHidden = true
            self.mainView.frame = CGRect(x: ScreenSize.widht/2, y: 40, width: 0, height: 50)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) { [self] in
            delegate?.closeButtonTapped(productId: productId)
            
        }
    }
    @objc func minusButtonTapped() {
        self.callback?(self)
        self.count! -= 1
        self.delegate?.minusButtonTapped(productId: productId, count: self.count!)
    }
    @objc func plusButtonTapped() {
        if count == 5 {
            GeneralPopup.showPopup(vc: self.viewController!, image: .error, title: "Error", subtitle: "You can add up to 5 products", buttonText: "Ok")
        } else {
            self.count! += 1
            self.delegate?.plusButtonTapped(productId: productId, count: self.count!)
        }
        
    }
    
    func configure(data : Product?,count : Int) {
        guard let data = data else {return}
        productTitlelabel.text = data.title
        self.productId = data.id!
        self.priceLabel.text = "$\(data.price!*Double(count).rounded(digits: 2))"
        self.countLabel.text = "\(count)"
        self.count = count
        self.productImageView.kf.setImage(with:URL(string: data.image ?? ""))
        self.deliveryDate(price: (data.price ?? 0.0)*Double(count))
        if count == 1 {
            self.minusButton.setImage(UIImage(systemName: "trash"), for: .normal)
        } else {
            self.minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
        }
    }
    
    func deliveryDate(price : Double) {
        switch price {
        case 0..<400.0 :
            let text =  "Delivery Date: \(Time().getDate())"
            deliveryDatelabel.attributedText = text.underlineAttriStringText(text: text,
                                                                             rangeText1: "Delivery Date:", rangeText1Font: .Regular_15, rangeText1Color: .black,
                                                                             rangeText2: "\(Time().getDate())", rangeText2Font: .Bold_15, rangeText2Color: .mainAppColor)
        default :
            let text =  "Delivery Date: Fast Delivery"
            deliveryDatelabel.attributedText = text.underlineAttriStringText(text: text,
                                                                             rangeText1: "Delivery Date:", rangeText1Font: .Regular_15, rangeText1Color: .black,
                                                                             rangeText2: "Fast Delivery", rangeText2Font: .Bold_15, rangeText2Color: .fastDeliveryColor)
            ToastMessage.showToastMessage(message: "Orders over $400 will reach you within days.", font: .Regular_18, y: ScreenSize.height/1.3, imgUrl: "box.truck.badge.clock.fill", vc: self.viewController!)
        }
    }
}

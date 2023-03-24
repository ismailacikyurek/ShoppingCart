//
//  CustomButton.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 5.03.2023.
//


import UIKit

extension UIButton {
    func createButton(title: String? = nil,
                      backgroundColor : UIColor? = nil,
                      titleColor : UIColor? = nil,
                      font : UIFont? = nil,
                      cornerRadius : CGFloat? = nil,
                      image : String? = nil,
                      zPozisition : CGFloat? = nil ) {
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.tintColor = titleColor
        self.titleLabel?.textColor = titleColor
        self.layer.cornerRadius = cornerRadius ?? 0
        self.layer.masksToBounds = true
        self.setImage(UIImage(named: image ?? ""), for: .normal)
        self.layer.zPosition = zPozisition ?? 0
    }
}
extension UIButton {
    func emptyCheckButton() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1
    }
    func addBorderColor(borderColor : CGColor) {
        self.layer.borderColor = borderColor
        self.layer.borderWidth = 1
    }
    
}

//
//  CustomTextField.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 5.03.2023.
//

import UIKit

extension UITextField {
    func createTextField(title: String? = nil,
                          backgroundColor : UIColor? = nil,
                          textColor : UIColor? = nil,
                          font : UIFont? = nil,
                          placeHolder : String? = nil,
                          cornerRadius : CGFloat? = nil,
                          zPozisition : CGFloat? = nil,
                          textAlignment : NSTextAlignment? = .left,
                          isSecureTextEntry: Bool? = nil,
                          borderWidth : CGFloat? = nil,
                          borderColor: CGColor? = nil,
                          attributedPlaceholder: String? = nil,
                          image: UIImage? = nil,
                          SecureTextEntry : Bool? = nil) {
            self.backgroundColor = backgroundColor
            self.text = title
            self.textColor = textColor
            self.layer.cornerRadius = cornerRadius ?? 0
            self.layer.masksToBounds = true
            self.layer.zPosition = zPozisition ?? 1
            self.font = font
            self.layer.borderColor = borderColor
            self.layer.borderWidth = borderWidth ?? 0.1
            self.textAlignment = textAlignment ?? .left
            self.autocapitalizationType = .none
            self.leftViewMode = .always
            self.placeholder = placeHolder
            self.translatesAutoresizingMaskIntoConstraints = true
            self.isSecureTextEntry = SecureTextEntry ?? false
            self.attributedPlaceholder = NSAttributedString(string:placeHolder ?? "" ,attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        
            let imageView = UIImageView()
            let image = image
            imageView.image = image
            imageView.tintColor = .systemGray
            leftView = imageView
            if let isSecureTextEntry = isSecureTextEntry {
            self.isSecureTextEntry = isSecureTextEntry
        }
//        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.width))
//        self.leftViewMode = .always
    }

}
  
extension UITextField {
    func makeError() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1
    }
    func removeError() {
        self.layer.borderColor = UIColor.green.cgColor
        self.layer.borderWidth = 1
    }
}

extension UITextField {
    func padding() {
                self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.width))
                self.leftViewMode = .always
    }
}
extension UITextField {
    func makeDropDownForAdress(){
        self.leftViewMode = .always
        let iconView = UIImageView(frame: CGRect(x: 16, y: 16, width: 16, height: 16))
        iconView.image = UIImage(named: "dropDown")
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 45))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightView?.isUserInteractionEnabled = false
        rightViewMode = .always
        self.tintColor = .lightGray
    }
}

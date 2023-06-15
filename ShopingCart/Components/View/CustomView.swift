//
//  CustomView.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 5.03.2023.
//

import UIKit

extension UIView {
    func createView(backgroundColor: UIColor? = nil,
                    maskedToBounds: Bool? = nil,
                    cornerRadius: CGFloat? = nil,
                    isUserInteractionEnabled: Bool? = nil,
                    image:String? = nil,
                    shadowColor : CGColor? = nil,
                    shadowOffset : CGSize? = nil,
                    clipsToBounds : Bool? = nil,
                    borderColor : CGColor? = nil,
                    borderWidth: CGFloat? = nil) {
        self.layer.masksToBounds = maskedToBounds ?? false
        self.layer.cornerRadius = cornerRadius ?? 0
        self.isUserInteractionEnabled = isUserInteractionEnabled ?? false
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = shadowOffset ?? .zero
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
        self.clipsToBounds = clipsToBounds ?? false
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth ?? 0
        
//        self.backgroundColor = UIColor(patternImage: UIImage(named: image ?? "")!)
    }
    func removeShadow() {
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0
    }

}

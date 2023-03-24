//
//  UIview+AddSubViews.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 6.03.2023.
//


import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for i in views {
            addSubview(i)
        }
    }
}

extension UIView {
    func roundCornersView(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

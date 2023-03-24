//
//  File.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 20.03.2023.
//

import UIKit
extension UITextView{
    func makeError() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1
    }
    func removeError() {
        self.layer.borderColor = UIColor.green.cgColor
        self.layer.borderWidth = 1
    }
}

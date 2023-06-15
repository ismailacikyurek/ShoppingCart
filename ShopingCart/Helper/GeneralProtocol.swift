//
//  generalProtocol.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 6.03.2023.
//

import Foundation
import UIKit

@objc protocol GeneralViewProtocol {
    func addView()
    func addTarget()
    func setupUI()
    func layoutUI()
    @objc optional func setupUICustom(title : String, subTitle : String, buttonText: String,image : UIImage)
}

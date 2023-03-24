//
//  ScreenSize.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 5.03.2023.
//


import UIKit

struct ScreenSize {
    static let widht = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

struct tabBarSize {
    static func tabbarPozisiton(tabbarMiny : CGFloat) -> Int {
        if ScreenSize.height > 800 {
            return Int(tabbarMiny-62)
        } else {
            return Int(tabbarMiny-32)
        }
    }
}

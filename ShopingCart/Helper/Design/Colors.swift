//
//  Colors.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 5.03.2023.
//


import UIKit

extension UIColor {
 
    
    @nonobjc class var  mainAppColor: UIColor {
        return UIColor(hexString:"#FC9D03")
    }
    @nonobjc class var  cartCountBackGroundColor: UIColor {
        return UIColor(hexString:"#FFFBEE")
    }
    
    @nonobjc class var profileUpViewBackGorundColor: UIColor {
        return UIColor(hexString:"#F3B03D")
    }
    
    @nonobjc class var  shadowColor: UIColor {
        return UIColor(red: 0.253, green: 0.46, blue: 0.81, alpha: 0.08)
    }
    
    @nonobjc class var borderColor: UIColor {
            return UIColor(hexString:"#444444")
    }
    @nonobjc class var fastDeliveryColor: UIColor {
            return UIColor(hexString:"#279521")
    }
    
    
    @nonobjc class var middleViewColor: UIColor {
            return UIColor(hexString:"#EEEEEE")
    }
    
    @nonobjc class var mainBorderColor: UIColor {
        return UIColor(hexString:"EBF0F2")
    }
}

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}







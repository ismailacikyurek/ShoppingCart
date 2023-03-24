//
//  String+Extension.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 8.03.2023.
//

import UIKit
extension String {
    // Text içinde ki bazı kelimelerin font ve rengini değiştirme
    func underlineAttriStringText(text : String, rangeText1 : String,rangeText1Font : UIFont,rangeText1Color : UIColor, rangeText2 : String,rangeText2Font : UIFont,rangeText2Color : UIColor) -> NSMutableAttributedString {
        
    let underlineAttriString = NSMutableAttributedString(string: text)
    let range1 = (text as NSString).range(of: rangeText1)
    
    underlineAttriString.addAttribute(NSAttributedString.Key.font, value: rangeText1Font, range: range1)
    underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: rangeText1Color, range: range1)

    let range2 = (text as NSString).range(of: rangeText2)
    underlineAttriString.addAttribute(NSAttributedString.Key.font, value: rangeText2Font, range: range2)
    underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: rangeText2Color, range: range2)
    return underlineAttriString
    }
}

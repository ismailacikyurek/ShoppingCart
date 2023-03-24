//
//  CustomPageControl.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 6.03.2023.
//

import UIKit
extension UIPageControl {
    func createPageControl(pageIndicatorTintColor: UIColor? = nil,
                           currentPageIndicatorTintColor: UIColor? = nil,
                           contentMode : ContentMode?,
                           backgroundColor: UIColor? = nil ) {
        self.pageIndicatorTintColor = .gray
        self.currentPageIndicatorTintColor = .orange
        self.contentMode = .scaleToFill
    }

}


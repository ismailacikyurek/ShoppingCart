//
//  Double+Extension.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 20.03.2023.
//
import UIKit

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}

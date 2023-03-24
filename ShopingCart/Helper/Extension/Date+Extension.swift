//
//  Date+Extension.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 23.03.2023.
//

import UIKit
import Foundation

class Time {
    func getDate() -> String{
        let currentDate = Date()
        
        var dateComponent = DateComponents()
        dateComponent.day = 2
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        var format = DateFormatter()
        format.timeStyle = .none
        format.dateStyle = .long
        format.locale = Locale(identifier: "en")
        let dateString = format.string(for: futureDate)
        return dateString!
    }

}

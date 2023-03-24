//
//  AlertMessage.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 5.03.2023.
//

import UIKit
    
class AlertMessage {
    static func alertMessageShow(title : String,message : String,vc: UIViewController) {
              let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
              let ok = UIAlertAction(title: "Ok", style: .default)
              alert.addAction(ok)
              vc.present(alert, animated: true)
    }
    public static func showAlertWithTwoCustomAction(vc: UIViewController, title: String, message: String, buttonTitle: String, secondButtonTitle: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let addAction = UIAlertAction(title: buttonTitle, style: .destructive) { action in
            if let completion = completion {
                completion()
            }
        }
        let addSecondAction = UIAlertAction(title: secondButtonTitle, style: .default)
        
        alert.addAction(addAction)
        alert.addAction(addSecondAction)
        vc.present(alert, animated: true, completion: nil)
    }
}


//
//  GeneralPopup.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 21.03.2023.
//


import UIKit

final class GeneralPopup {
 
    static public func showPopup(vc:UIViewController,image : SuccessfulOrError,title : String?, subtitle:String?, buttonText:String) {
            let popupVC = GeneralPopupViewController()
            popupVC.modalPresentationStyle = .popover
            popupVC.setPopup(image: image, title: title, subtitle: subtitle, buttonText: buttonText)
            vc.present(popupVC, animated: true)
    }
}

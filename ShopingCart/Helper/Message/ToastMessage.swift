//
//  ToastMessage.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 6.03.2023.
//
import UIKit
import Kingfisher

class ToastMessage {
 
    public static func showToastMessage(message : String, font: UIFont,y:CGFloat,imgUrl : String, vc: UIViewController) {
        let view = UIView(frame: CGRect(x: 10, y: y, width: ScreenSize.widht-20, height: 45))
        view.layer.backgroundColor = UIColor.fastDeliveryColor.cgColor
        view.alpha = 1.0
        view.layer.cornerRadius = 14
        view.clipsToBounds  =  true
        
        let image = UIImageView(frame: CGRect(x: 15, y: y + 10, width: 25, height: 25))
//        image.kf.setImage(with:URL(string:imgUrl ?? ""))
        image.image = UIImage(systemName: imgUrl)
        image.tintColor = .white
        image.contentMode = .scaleAspectFill
        image.alpha = 1.0
        
        let messageLabel = UILabel(frame: CGRect(x: 45, y: y + 2, width: view.frame.width - 40 , height: 42))
        messageLabel.textColor = UIColor.white
        messageLabel.font = font
        messageLabel.adjustsFontSizeToFitWidth = true
        messageLabel.minimumScaleFactor = 0.2
        messageLabel.numberOfLines = 1
        messageLabel.text = message
        
        vc.view.addSubview(view)
        vc.view.addSubview(messageLabel)
        vc.view.addSubview(image)

        UIView.animate(withDuration: 4.0, delay: 1.0, options: .curveEaseOut, animations: {
            messageLabel.alpha = 0.0
            image.alpha = 0.0
            view.alpha = 0.0
        }, completion: {(isCompleted) in
            messageLabel.removeFromSuperview()
            image.removeFromSuperview()
            view.removeFromSuperview()
        })
    }
}

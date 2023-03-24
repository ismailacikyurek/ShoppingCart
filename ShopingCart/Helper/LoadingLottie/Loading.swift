//
//  Loading.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 9.03.2023.
//

import UIKit

final class Loading {
 
    static public func startLoading(vc:UIViewController) {
            let loadingVC = LoadingViewController()
            loadingVC.modalPresentationStyle = .overFullScreen
            vc.present(loadingVC, animated: true)
    }
    
    static public func stopLoading(vc:UIViewController) {
        vc.dismiss(animated: true)
    }
    
}

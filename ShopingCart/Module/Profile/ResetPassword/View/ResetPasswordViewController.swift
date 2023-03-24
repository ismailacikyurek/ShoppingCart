//
//  ResetPasswordViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 9.03.2023.
//

import UIKit
import SnapKit

class ResetPasswordViewController: UIViewController {
    
    private let resetPasswordView = ResetPasswordView()
    private let profileViewModel = ProfileViewModel()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view = resetPasswordView
        resetPasswordView.interface = self
        profileViewModel.delegateResetPassword = self
    }
}

extension ResetPasswordViewController : ProfileViewModelResetPasswordProtocol {
    
    func didResetPasswordError(_ error: Error) {
        GeneralPopup.showPopup(vc: self, image: .error, title: "Error", subtitle: error.localizedDescription, buttonText: "Ok")
    }
    
    func didResetPasswordSuccessful() {
        GeneralPopup.showPopup(vc: self, image: .succces, title: "Successful", subtitle: "Congratulations. A password reset link has been sent to your e-mail address.", buttonText: "Ok")
    }
}

extension ResetPasswordViewController : ResetPasswordViewInterfaceProtocol {
    func ResetPasswordViewSendButton(email: String?) {
        profileViewModel.resetPassword(email: email!)
    }
}

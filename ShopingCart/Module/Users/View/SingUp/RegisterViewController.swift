//
//  SingUpViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 6.03.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    private let registerView = RegisterView()
    private let usersViewModel = UsersViewModel()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = registerView
        registerView.interface = self
        usersViewModel.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
    }
}

extension RegisterViewController : RegisterViewInterfaceProtocol {
    func registerViewAgreementLabelTapped() {
        let agreementVC = AgreementViewController()
        agreementVC.modalPresentationStyle = .pageSheet
        present(agreementVC, animated: true)
    }
    
    func passwordShortError() {
        let popup = GeneralPopupViewController()
        GeneralPopup.showPopup(vc: self, image: .error, title: "Error", subtitle: "Passwords is Short", buttonText: "Ok")
    }
    
    func registerViewSingInTapped() {
        let LoginVC = LoginViewController()
        LoginVC.modalPresentationStyle = .overFullScreen
        present(LoginVC, animated: true)
        //        navigationController?.pushViewController(LoginVC, animated: true)
    }
    
    func registerViewSingUpTapped() {
        
        let username = registerView.usernameTextField.text
        let email = registerView.emailTextField.text
        let password  = registerView.passwordTextField.text
        let confirmPassword = registerView.againPasswordTextField.text
        
        guard password == confirmPassword else {
            GeneralPopup.showPopup(vc: self, image: .error, title: "Error", subtitle: "Passwords Do Not Match", buttonText: "Ok")
            return
        }
        Loading.startLoading(vc: self)
        usersViewModel.register(username: username!, email: email!, password: password!)
    }
    
}

extension RegisterViewController: UsersViewModelProtocol {
    func didError(_ error: Error) {
        GeneralPopup.showPopup(vc: self, image: .error, title: "Error", subtitle: error.localizedDescription, buttonText: "Ok")
    }
    
    func didSignUpSuccessful() {
        Loading.stopLoading(vc: self)
        GeneralPopup.showPopup(vc: self, image: .succces, title: "Successful", subtitle: "Recorded", buttonText: "Ok")
        let signInVC = LoginViewController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    func didSignInSuccessful() {}
}


//
//  LoginViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 8.03.2023.
//
import UIKit

class LoginViewController: UIViewController{
    
    private let loginView = LoginView()
    private let usersViewModel = UsersViewModel()
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
        loginView.interface = self
        usersViewModel.delegate = self
    }
}

extension LoginViewController : LoginViewInterfaceProtocol {
    func loginViewSingInTapped() {
        guard let email = loginView.emailTextField.text,
              let password  = loginView.passwordTextField.text else {return}
        usersViewModel.login(email:email , password: password)
    }
    
    func loginViewSingUpTapped() {
        let singUp = RegisterViewController()
        singUp.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(singUp, animated: true)
    }
    
}

extension LoginViewController: UsersViewModelProtocol {
    func didError(_ error: Error) {
        AlertMessage.alertMessageShow(title: "Error", message: error.localizedDescription, vc: self)
    }
    func didSignUpSuccessful() {}
    func didSignInSuccessful() {
        let tabbar = MainTabBarController()
        tabbar.modalPresentationStyle = .fullScreen
        present(tabbar, animated: true)
    }
}

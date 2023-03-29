//
//  LoginView.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 8.03.2023.

import UIKit
import SnapKit

protocol LoginViewInterfaceProtocol: AnyObject {
    func loginViewSignInTapped()
    func loginViewSignUpTapped()
}

class LoginView: UIView {
    
    // MARK: UIComponent
    lazy var signInLabel = UILabel()
    lazy var upView = UIView()
    lazy var middleView = UIView()
    lazy var emailTextField = UITextField()
    lazy var passwordTextField = UITextField()
    lazy var signInButton = UIButton()
    lazy var signUpLabel = UILabel()
    lazy var securityButton = UIButton()
    
    var securityPassword = false
    weak var interface: LoginViewInterfaceProtocol?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        addView()
        addTarget()
        layoutUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: AddSubiew,AddTarget,LayoutUI,SetupUI

extension LoginView : GeneralViewProtocol {
    func addTarget() {
        signInButton.addTarget(self, action:#selector(signInTapped), for: .touchUpInside)
        securityButton.addTarget(self, action:#selector(securityButtonTapped), for: .touchUpInside)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpLabelTapped))
        self.signUpLabel.addGestureRecognizer(gestureRecognizer)
        
        let viewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editKeyboard))
        self.addGestureRecognizer(viewGestureRecognizer)
    }
    
    func setupUI() {
        self.backgroundColor = .white
        upView.createView(backgroundColor: UIColor(patternImage: UIImage(named:"registerBack")!))
        middleView.createView(backgroundColor: .white,cornerRadius: 22,shadowColor: UIColor.gray.cgColor,shadowOffset: CGSize(width: 5, height: 5))
        signInLabel.createLabel(text: "SignIn",backgroundColor: .clear, textColor: .mainAppColor,font: .Bold_44,textAlignment: .center)
        emailTextField.createTextField(backgroundColor: .middleViewColor, placeHolder: " Email", cornerRadius: 15,image: UIImage(systemName: "envelope")!)
        passwordTextField.createTextField(backgroundColor: .middleViewColor,placeHolder: " Password", cornerRadius: 15,image: UIImage(systemName: "lock.circle")!,SecureTextEntry: true)
        signInButton.createButton(title: "Sign In",backgroundColor: .mainAppColor,titleColor: .black,font: .Semibold_18,cornerRadius: 15)
        
        signUpLabel.createLabel(text: "Not a Member? Sign Up", backgroundColor: .clear, font: .Regular_15, numberOfLines: 2,textAlignment: .center)
        let textAgrement = "Not a Member? Sign Up"
        signUpLabel.attributedText = textAgrement.underlineAttriStringText(text: "Not a Member? Sign Up", rangeText1: "", rangeText1Font: .Regular_15, rangeText1Color: .black, rangeText2: "Sign Up", rangeText2Font: .Regular_15, rangeText2Color: .mainAppColor)
        securityButton.createButton(titleColor: .systemGray)
        securityButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
    }
    
    func layoutUI() {
        upViewConstraints()
        middleViewConstraints()
        signInLabelConstraints()
        emailTextFiledConstraints()
        passwordTextFiledConstraints()
        signInButtonConstraints()
        signUpLabelConstraints()
        securityButtonConstraints()
    }
    
    func addView() {
        addSubviews(upView,middleView,signInLabel,emailTextField,passwordTextField,signInButton,signUpLabel)
        passwordTextField.addSubview(securityButton)
    }
}

extension LoginView  {
    //MARK: UI Action
    @objc func signInTapped() {
        if emailTextField.text == "" {
            emailTextField.makeError()
        } else if passwordTextField.text == "" {
            emailTextField.removeError()
            passwordTextField.makeError()
        } else {
            interface?.loginViewSignInTapped()
        }
        
    }
    @objc func securityButtonTapped() {
        if securityPassword == false {
            securityButton.setImage(UIImage(systemName: "eye"), for: .normal)
            self.securityPassword = true
            self.passwordTextField.isSecureTextEntry = false
        } else {
            securityButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            self.securityPassword = false
            self.passwordTextField.isSecureTextEntry = true
        }
    }
    @objc func SignUpLabelTapped() {
        interface?.loginViewSignUpTapped()
    }
    @objc func editKeyboard() {
        self.endEditing(true)
    }
}

//MARK: Constraints
extension LoginView  {
    func upViewConstraints() {
        self.upView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(0)
            make.leading.trailing.equalTo(self).offset(0)
            make.height.equalTo(ScreenSize.height/2)
        }
    }
    func middleViewConstraints() {
        self.middleView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(100)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
            make.height.equalTo(ScreenSize.height-160)
        }
    }
    
    func signInLabelConstraints() {
        self.signInLabel.snp.makeConstraints { make in
            make.top.equalTo(middleView.snp.top).offset(20)
            make.leading.trailing.equalTo(self).offset(0)
            make.height.equalTo(60)
        }
    }
    
    func emailTextFiledConstraints() {
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(signInLabel.snp.bottom).offset(40)
            make.leading.equalTo(self.snp.leading).offset(25)
            make.trailing.equalTo(self.snp.trailing).offset(-25)
            make.height.equalTo(50)
        }
    }
    
    func passwordTextFiledConstraints(){
        self.passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(emailTextField).offset(0)
            make.height.equalTo(emailTextField)
        }
    }
    
    func signInButtonConstraints() {
        self.signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(emailTextField).offset(0)
            make.height.equalTo(emailTextField)
        }
    }
    
    func signUpLabelConstraints() {
        self.signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(middleView.snp.bottom).offset(-30)
            make.leading.trailing.equalTo(passwordTextField).offset(0)
            make.height.equalTo(30)
        }
    }
    func securityButtonConstraints() {
        self.securityButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField).offset(10)
            make.trailing.equalTo(passwordTextField).offset(-7)
            make.height.width.equalTo(30)
        }
    }
    
}

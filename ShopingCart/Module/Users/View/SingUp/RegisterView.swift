//
//  SignUpView.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 6.03.2023.
//

import UIKit
import SnapKit

protocol RegisterViewInterfaceProtocol: AnyObject {
    func registerViewSignInTapped()
    func registerViewSignUpTapped()
    func passwordShortError()
    func registerViewAgreementLabelTapped()
}

class RegisterView: UIView {
    
    // MARK: UIComponent
    lazy var titleLabel = UILabel()
    lazy var usernameTextField = UITextField()
    lazy var emailTextField = UITextField()
    lazy var passwordTextField = UITextField()
    lazy var againPasswordTextField = UITextField()
    lazy var signUpButton = UIButton()
    lazy var signUPLabel = UILabel()
    lazy var signInLabel = UILabel()
    lazy var upView = UIView()
    lazy var middleView = UIView()
    lazy var agreementCheckButton = UIButton()
    lazy var agreementLabel = UILabel()
    lazy var securityButton = UIButton()
    lazy var securityAgainButton = UIButton()
    
    var securityPassword = false
    var securityPasswordAgain = false
    var checkButton : Bool? = false
    weak var interface: RegisterViewInterfaceProtocol?
    
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

extension RegisterView : GeneralViewProtocol {
    func addTarget() {
        signUpButton.addTarget(self, action:#selector(signUpTapped), for: .touchUpInside)
        securityButton.addTarget(self, action:#selector(securityButtonTapped), for: .touchUpInside)
        securityAgainButton.addTarget(self, action:#selector(securityAgainButtonTapped), for: .touchUpInside)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(signInTapped))
        self.signInLabel.addGestureRecognizer(gestureRecognizer)
        
        agreementCheckButton.addTarget(self, action:#selector(checkButtonTapped), for: .touchUpInside)
        
        let gestureRecognizerAgreementLabel = UITapGestureRecognizer(target: self, action: #selector(agreementTapped))
        self.agreementLabel.addGestureRecognizer(gestureRecognizerAgreementLabel)
        
        let viewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editKeyboard))
        self.addGestureRecognizer(viewGestureRecognizer)
    }
    
    func setupUI() {
        self.backgroundColor = .white
        upView.createView(backgroundColor: UIColor(patternImage: UIImage(named:"registerBack")!))
        middleView.createView(backgroundColor: .white,cornerRadius: 22,shadowColor: UIColor.gray.cgColor,shadowOffset: CGSize(width: 5, height: 5))
        signUPLabel.createLabel(text: "SignUp",backgroundColor: .clear, textColor: .mainAppColor,font: .Bold_44,textAlignment: .center)
        
        usernameTextField.createTextField(backgroundColor: .middleViewColor, placeHolder: " Username",cornerRadius: 15,image: UIImage(systemName: "person")!)
        emailTextField.createTextField(backgroundColor: .middleViewColor, placeHolder: " Email", cornerRadius: 15,image: UIImage(systemName: "envelope")!)
        passwordTextField.createTextField(backgroundColor: .middleViewColor,placeHolder: " Password", cornerRadius: 15,image: UIImage(systemName: "lock.circle")!,SecureTextEntry: true)
        againPasswordTextField.createTextField(backgroundColor: .middleViewColor, placeHolder: " Again Password", cornerRadius: 15,image: UIImage(systemName: "lock.circle")!,SecureTextEntry: true)
        signUpButton.createButton(title: "Sign Up",backgroundColor: .mainAppColor,titleColor: .black,font: .Semibold_18,cornerRadius: 15)
        agreementCheckButton.createButton(title: "",backgroundColor: .white,image: "unselected")
        
        agreementLabel.createLabel(text: "I have read the membership agreement, I accept.", backgroundColor: .clear, font: .Regular_15, numberOfLines: 2,textAlignment: .left)
        let textAgrement = "I have read the membership agreement, I accept."
        agreementLabel.attributedText = textAgrement.underlineAttriStringText(text: "I have read the membership agreement, I accept.", rangeText1: "", rangeText1Font: .Regular_15, rangeText1Color: .black, rangeText2: "membership agreement", rangeText2Font: .Regular_15, rangeText2Color: .mainAppColor)
        
        
        signInLabel.createLabel(text: "Already a Member? Sign In", backgroundColor: .clear,font: .Regular_15,textAlignment: .center)
        let text = "Already a Member? Sign In"
        signInLabel.attributedText = text.underlineAttriStringText(text: "Already a Member? Sign In", rangeText1: "Already a Member?", rangeText1Font: .Regular_15, rangeText1Color: .black, rangeText2: "Sign In", rangeText2Font: .Regular_15, rangeText2Color: .mainAppColor)
        
        securityButton.createButton(titleColor: .systemGray)
        securityButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        
        securityAgainButton.createButton(titleColor: .systemGray)
        securityAgainButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
    }
    func layoutUI() {
        upViewConstraints()
        middleViewConstraints()
        signUpLabelConstraints()
        usernameTextFiledConstraints()
        emailTextFiledConstraints()
        passwordTextFiledConstraints()
        againPasswordTextFiledConstraints()
        signUpButtonConstraints()
        agremmentLabelConstraints()
        agremmentCheckButtonConstraints()
        signInLabelConstraints()
        securityButtonConstraints()
        securityAgainButtonConstraints()
    }
    
    func addView() {
        addSubviews(upView,middleView,signUPLabel,usernameTextField,emailTextField,passwordTextField,againPasswordTextField,signUpButton,signInLabel,agreementCheckButton,agreementLabel)
        passwordTextField.addSubview(securityButton)
        againPasswordTextField.addSubview(securityAgainButton)
        
    }
}

extension RegisterView  {
    //MARK: UI Action
    @objc func signInTapped() {
        interface?.registerViewSignInTapped()
    }
    @objc func signUpTapped() {
        if usernameTextField.text == "" {
            usernameTextField.makeError()
        } else if emailTextField.text == "" {
            usernameTextField.removeError()
            emailTextField.makeError()
        } else if passwordTextField.text == "" {
            usernameTextField.removeError()
            emailTextField.removeError()
            passwordTextField.makeError()
        } else if againPasswordTextField.text == "" {
            usernameTextField.removeError()
            emailTextField.removeError()
            passwordTextField.removeError()
            againPasswordTextField.makeError()
        } else if passwordTextField.text!.count < 6 {
            usernameTextField.removeError()
            emailTextField.removeError()
            passwordTextField.makeError()
            againPasswordTextField.makeError()
            interface?.passwordShortError()
        }else if checkButton == false {
            agreementCheckButton.emptyCheckButton()
        }
        else {
            interface?.registerViewSignUpTapped()
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
    @objc func securityAgainButtonTapped() {
        if securityPasswordAgain == false {
            securityAgainButton.setImage(UIImage(systemName: "eye"), for: .normal)
            self.securityPasswordAgain = true
            self.againPasswordTextField.isSecureTextEntry = false
        } else {
            securityAgainButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            self.securityPasswordAgain = false
            self.againPasswordTextField.isSecureTextEntry = true
        }
    }
    @objc func checkButtonTapped() {
        if checkButton == false {
            checkButton = true
            agreementCheckButton.setImage(UIImage(named: "selected"), for: .normal)
        } else {
            checkButton = false
            agreementCheckButton.setImage(UIImage(named: "unselected"), for: .normal)
        }
        
    }
    @objc func agreementTapped() {
        interface?.registerViewAgreementLabelTapped()
    }
    @objc func editKeyboard() {
        self.endEditing(true)
    }
}

//MARK: Constraints
extension RegisterView  {
    func upViewConstraints() {
        self.upView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(0)
            make.leading.trailing.equalTo(self).offset(0)
            make.height.equalTo(ScreenSize.height/2)
        }
    }
    func middleViewConstraints() {
        self.middleView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(80)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
            make.height.equalTo(ScreenSize.height-160)
        }
    }
    
    func signUpLabelConstraints() {
        self.signUPLabel.snp.makeConstraints { make in
            make.top.equalTo(middleView.snp.top).offset(20)
            make.leading.trailing.equalTo(self).offset(0)
            make.height.equalTo(60)
        }
    }
    
    
    func usernameTextFiledConstraints() {
        self.usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(signUPLabel.snp.bottom).offset(20)
            make.leading.equalTo(self.snp.leading).offset(25)
            make.trailing.equalTo(self.snp.trailing).offset(-25)
            make.height.equalTo(45)
        }
    }
    func emailTextFiledConstraints() {
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(15)
            make.leading.trailing.equalTo(usernameTextField).offset(0)
            make.height.equalTo(usernameTextField).offset(0)
        }
    }
    func passwordTextFiledConstraints() {
        self.passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.leading.trailing.equalTo(usernameTextField).offset(0)
            make.height.equalTo(usernameTextField).offset(0)
        }
    }
    func againPasswordTextFiledConstraints() {
        self.againPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.leading.trailing.equalTo(usernameTextField).offset(0)
            make.height.equalTo(usernameTextField).offset(0)
        }
    }
    func signUpButtonConstraints() {
        self.signUpButton.snp.makeConstraints { make in
            make.top.equalTo(againPasswordTextField.snp.bottom).offset(15)
            make.leading.trailing.equalTo(usernameTextField).offset(0)
            make.height.equalTo(usernameTextField).offset(0)
        }
    }
    func agremmentCheckButtonConstraints() {
        self.agreementCheckButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(5)
            make.leading.equalTo(usernameTextField).offset(0)
            make.height.width.equalTo(20)
        }
    }
    func agremmentLabelConstraints() {
        self.agreementLabel.snp.makeConstraints { make in
            make.top.equalTo(agreementCheckButton.snp.top).offset(-5)
            make.leading.equalTo(agreementCheckButton.snp.trailing).offset(7)
            make.height.equalTo(30)
        }
    }
    func signInLabelConstraints() {
        self.signInLabel.snp.makeConstraints { make in
            make.top.equalTo(middleView.snp.bottom).offset(-30)
            make.leading.equalTo(usernameTextField.snp.leading).offset(0)
            make.trailing.equalTo(usernameTextField.snp.trailing).offset(0)
            make.height.equalTo(30)
        }
    }
    func securityButtonConstraints() {
        self.securityButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.top).offset(2)
            make.trailing.equalTo(passwordTextField.snp.trailing).offset(-10)
            make.height.width.equalTo(40)
        }
    }
    func securityAgainButtonConstraints() {
        self.securityAgainButton.snp.makeConstraints { make in
            make.top.equalTo(againPasswordTextField.snp.top).offset(2)
            make.trailing.equalTo(againPasswordTextField.snp.trailing).offset(-10)
            make.height.width.equalTo(40)
        }
        
    }
}

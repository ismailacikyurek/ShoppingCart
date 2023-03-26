//
//  ResetPasswordView.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 9.03.2023.
//

import UIKit
import SnapKit

//MARK: Protocols
protocol ResetPasswordViewInterfaceProtocol: AnyObject {
    func resetPasswordViewSendButton(email : String?)
}
class ResetPasswordView: UIView {
    
    // MARK: UIComponent
    lazy var titleLabel = UILabel()
    lazy var upView = UIView()
    lazy var middleView = UIView()
    lazy var descriptionLabel = UILabel()
    lazy var emailTextField = UITextField()
    lazy var sendButton = UIButton()
    
    weak var interface: ResetPasswordViewInterfaceProtocol?
    var email : String?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
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

extension ResetPasswordView : GeneralViewProtocol {
    func addTarget() {
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        let viewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editKeyboard))
        self.addGestureRecognizer(viewGestureRecognizer)
    }
    
    func setupUI() {
        self.backgroundColor = .white
        titleLabel.createLabel(text: "Reset Password", textColor : .white, font: .Bold_44, zPozisition: 2, textAlignment: .center)
        upView.createView(backgroundColor: UIColor(patternImage: UIImage(named:"registerBack")!))
        middleView.createView(backgroundColor: .white,cornerRadius: 22,shadowColor: UIColor.gray.cgColor,shadowOffset: CGSize(width: 5, height: 5))
        descriptionLabel.createLabel(text: "Type your e-mail address where you want to reset your password.",textColor: .black,font: .Regular_18,zPozisition: 2,numberOfLines: 3,textAlignment: .left)
        emailTextField.createTextField(backgroundColor: .middleViewColor, placeHolder: " Email", cornerRadius: 15,image: UIImage(systemName: "envelope")!)
        sendButton.createButton(title: "Send", backgroundColor: .mainAppColor, titleColor: .white, font: .Semibold_18, cornerRadius: 15, zPozisition: 2)
        
    }
    
    func layoutUI() {
        upViewConstraints()
        middleViewConstraints()
        titleLabelConstraints()
        descriptionLabelConstraints()
        emailTextFieldConstraints()
        sendButtonConstraints()
    }
    
    func addView() {
        addSubviews(titleLabel,descriptionLabel,emailTextField,upView,middleView,sendButton)
    }
}
extension ResetPasswordView {
    //MARK: UI Action
    @objc func sendButtonTapped() {
        self.email = emailTextField.text
        guard let email = self.email else {return; emailTextField.makeError() }
        interface?.resetPasswordViewSendButton(email: email)
    }
    @objc func editKeyboard() {
        self.endEditing(true)
    }
}

//MARK: Constraints
extension ResetPasswordView {
    func upViewConstraints() {
        self.upView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(0)
            make.leading.equalTo(self.snp.leading).offset(0)
            make.width.equalTo(ScreenSize.widht)
            make.height.equalTo(ScreenSize.height/2)
        }
    }
    
    func middleViewConstraints() {
        self.middleView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(100)
            make.bottom.equalTo(self.snp.bottom).offset(-100)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
        }
    }
    
    func titleLabelConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(30)
            make.leading.trailing.equalTo(self).offset(0)
            make.height.equalTo(40)
            
        }
    }
    
    func descriptionLabelConstraints() {
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(middleView.snp.top).offset(20)
            make.leading.equalTo(self.middleView.snp.leading).offset(5)
            make.trailing.equalTo(self.middleView.snp.trailing).offset(-5)
            make.height.equalTo(70)
        }
    }
    
    func emailTextFieldConstraints() {
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(230)
            make.leading.equalTo(self.middleView.snp.leading).offset(5)
            make.trailing.equalTo(self.middleView.snp.trailing).offset(-5)
            make.height.equalTo(50)
        }
    }
    
    func sendButtonConstraints() {
        self.sendButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.emailTextField).offset(0)
            make.height.equalTo(50)
        }
    }
}

//
//  generalPopupViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 8.03.2023.
//

import UIKit

class GeneralPopupViewController: UIViewController {
 
    // MARK: UIComponent
    lazy var contenView = UIView()
    lazy var popupImageView = UIImageView()
    lazy var titleLabel = UILabel()
    lazy var subTitleLabel =  UILabel()
    lazy var doneButton = UIButton()
    
    var image:UIImage?
    var titleString:String?
    var subtitle:String?
    var buttonText:String!
    var buttonFunc: () -> Void = {}
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        setupUI()
        addView()
        addTarget()
        layoutUI()
    }
    
    func setPopup(image : SuccessfulOrError,title : String?, subtitle:String?, buttonText:String) {
        if image == .error {
            self.image = UIImage(named: "error")
        } else {
            self.image = UIImage(named: "success")
        }
        self.titleString = title
        self.subtitle = subtitle
        self.buttonText = buttonText
    }
    
    //MARK: UI Action
    @objc func doneButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        self.buttonFunc()
    }
}
//MARK: AddSubiew,AddTarget,LayoutUI,SetupUI
extension GeneralPopupViewController : GeneralViewProtocol {
    func addTarget() {
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    func setupUI() {
        contenView.createView(backgroundColor: .white, cornerRadius: 15, clipsToBounds: true)
        popupImageView.createUIImageView(image: image,contentMode: .scaleToFill)
        titleLabel.createLabel(text: titleString, backgroundColor: .mainAppColor, textColor: .white,font: .Semibold_22, textAlignment: .center)
        subTitleLabel.createLabel(text: subtitle, backgroundColor: .white, textColor: .black, font: .Regular_14, numberOfLines: 3, textAlignment: .center)
        doneButton.createButton(title: buttonText,backgroundColor: .mainAppColor,titleColor: .white,cornerRadius: 20)
    }
    
    func layoutUI() {
        contentViewConstraints()
        titleLabelConstraints()
        popupImageViewConstraints()
        subTitleLabelConstraints()
        doneButtonConstraints()
    }
    
    func addView() {
        view.addSubviews(contenView,doneButton)
        contenView.addSubviews(titleLabel,popupImageView,subTitleLabel)
    }
}

//MARK: Constraints
extension GeneralPopupViewController {
    func contentViewConstraints() {
        contenView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(130)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
            make.height.equalTo(290)
        }
    }
    func titleLabelConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contenView).offset(0)
            make.leading.equalTo(contenView).offset(0)
            make.trailing.equalTo(contenView).offset(0)
            make.height.equalTo(45)
        }
    }
    func popupImageViewConstraints() {
        popupImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalTo(contenView).offset(0)
            make.height.width.equalTo(90)
        }
    }
    func subTitleLabelConstraints() {
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(popupImageView.snp.bottom).offset(5)
            make.leading.equalTo(contenView).offset(10)
            make.trailing.equalTo(contenView).offset(-10)
            make.height.equalTo(80)
        }
    }
    func doneButtonConstraints() {
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(contenView.snp.bottom).offset(-50)
            make.leading.equalTo(contenView).offset(70)
            make.trailing.equalTo(contenView).offset(-70)
            make.height.equalTo(45)
        }
    }
}


enum SuccessfulOrError {
    case error
    case succces
}

//
//  addAddressView.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 20.03.2023.
//

import UIKit
import SnapKit

//MARK: Protocols
protocol AddAddressViewProtocol: AnyObject {
    func dissmisButtonTapped()
    func addAddressButtonTapped(AddressName : String, Address : String)
}

class AddAddressView: UIView {
    
    // MARK: UIComponent
    lazy var backButton = UIButton()
    lazy var title = UILabel()
    lazy var addressNameTextField = UITextField()
    lazy var addressDecriptionTextView = UITextView()
    lazy var addressCityTextField = UITextField()
    lazy var addAddressButton = UIButton()
    lazy var seperatorView = UIView()
    lazy var addressTableView = UITableView()
    lazy var thePicker = UIPickerView()
    
    weak var interface : AddAddressViewProtocol?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addView()
        setupUI()
        layoutUI()
        addTarget()
        addressCityTextFieldThePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: AddSubiew,AddTarget,LayoutUI,SetupUI
extension AddAddressView : GeneralViewProtocol {
    func setupUI() {
        self.backgroundColor = .white
        
        backButton.setImage(UIImage.init(named: "backButton"), for: .normal)
        backButton.tintColor = .black
        
        title.createLabel(text: "My Address", textColor: .black, font: .Bold_15, textAlignment: .center)
        
        addressNameTextField.createTextField(backgroundColor: .middleViewColor, placeHolder: " Address Name", cornerRadius: 15)
        addressNameTextField.padding()
        
        addressDecriptionTextView.backgroundColor = .middleViewColor
        addressDecriptionTextView.layer.cornerRadius = 15
        
        addressCityTextField.delegate = self
        addressCityTextField.createTextField(placeHolder: "Select City",cornerRadius: 10,borderWidth: 1,borderColor: UIColor.mainAppColor.cgColor)
        addressCityTextField.padding()
        addressCityTextField.makeDropDownForAdress()
        
        addAddressButton.createButton(title: "Add Address", backgroundColor: .mainAppColor, cornerRadius: 10)
        
        seperatorView.createView(backgroundColor: .gray)
        
        thePicker.isHidden = true
    }
    
    func layoutUI() {
        backButtonConstraints()
        titleConstraints()
        addressNameTextFieldConstraints()
        addressDecriptionTextViewConstraints()
        addressCityTextFieldConstraints()
        addAddressButtonConstraints()
        seperatorViewConstraints()
        addressTableViewConstraints()
    }
    
    func addView() {
        addSubviews(addressTableView,backButton,title,thePicker,addressCityTextField,addressNameTextField,seperatorView,addressDecriptionTextView,addAddressButton)
    }
    
    func addTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        addAddressButton.addTarget(self, action: #selector(addAddressButtonTapped), for: .touchUpInside)
    }
}
extension AddAddressView {
    
    func addressCityTextFieldThePicker() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action:  #selector(self.cancelPicker))
        
        toolBar.setItems([cancelButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.addressCityTextField.inputAccessoryView = toolBar
        addressCityTextField.inputView = thePicker
    }
    
    //MARK: UI Action
    @objc func cancelPicker() {
        self.endEditing(true)
    }
    @objc func backButtonTapped() {
        interface?.dissmisButtonTapped()
    }
    @objc func addAddressButtonTapped() {
        if let addressName = addressNameTextField.text, let address = addressDecriptionTextView.text,let cityName = addressCityTextField.text{
            if addressName == ""  {
                addressNameTextField.makeError()
            } else if address == ""  {
                addressNameTextField.removeError()
                addressDecriptionTextView.makeError()
            } else if cityName == ""  {
                addressNameTextField.removeError()
                addressDecriptionTextView.removeError()
                addressCityTextField.makeError()
            } else {
                interface?.addAddressButtonTapped(AddressName: addressName, Address: address + "/" + cityName )
            }
        }
    }
    
    func inputClear() {
        //clear after recording
        self.addressNameTextField.text = ""
        self.addressDecriptionTextView.text = ""
        self.addressCityTextField.text = ""
        
        self.addressNameTextField.layer.borderWidth = 0
        self.addressDecriptionTextView.layer.borderWidth = 0
        self.addressCityTextField.layer.borderWidth = 1
        self.addressCityTextField.layer.borderColor = UIColor.mainAppColor.cgColor
    }
}
extension AddAddressView : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        thePicker.isHidden = false
    }
}

//MARK: Constraints
extension AddAddressView {
    
    func titleConstraints() {
        self.title.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(50)
            make.leading.equalTo(self.snp.leading).offset(36)
            make.trailing.equalTo(self.snp.trailing).offset(-36)
            make.height.equalTo(30)
        }
    }
    func backButtonConstraints() {
        self.backButton.snp.makeConstraints { make in
            make.top.equalTo(title).offset(0)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
    }
    
    func addressNameTextFieldConstraints() {
        self.addressNameTextField.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.equalTo(40)
        }
    }
    
    func addressDecriptionTextViewConstraints() {
        self.addressDecriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(addressNameTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(addressNameTextField).offset(0)
            make.height.equalTo(80)
        }
    }
    func addressCityTextFieldConstraints() {
        self.addressCityTextField.snp.makeConstraints { make in
            make.top.equalTo(addressDecriptionTextView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(addressNameTextField).offset(0)
            make.height.equalTo(40)
        }
    }
    
    func addAddressButtonConstraints() {
        self.addAddressButton.snp.makeConstraints { make in
            make.top.equalTo(addressCityTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(addressNameTextField).offset(0)
            make.height.equalTo(40)
        }
    }
    func seperatorViewConstraints() {
        self.seperatorView.snp.makeConstraints { make in
            make.top.equalTo(addAddressButton.snp.bottom).offset(15)
            make.leading.trailing.equalTo(addressNameTextField).offset(0)
            make.height.equalTo(1)
        }
    }
    func addressTableViewConstraints() {
        self.addressTableView.snp.makeConstraints { make in
            make.top.equalTo(seperatorView.snp.bottom).offset(5)
            make.leading.trailing.equalTo(addressNameTextField).offset(0)
            make.height.equalTo(ScreenSize.height/2.5)
        }
    }
    
}


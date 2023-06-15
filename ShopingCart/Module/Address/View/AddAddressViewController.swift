//
//  AddAddressViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 20.03.2023.


import UIKit

final class AddAddressViewController: UIViewController {
    
    private let addressViewModel = AddressViewModel(service: WebService())
    let addAddressView = AddAddressView()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = addAddressView
        addAddressView.interface = self
        addressViewModel.delegate = self
        self.addressViewModel.fetchCityList()
        setupPickerDelegates()
        setTableViewDelegates()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addressViewModel.fetchAddressList()
    }
}
// MARK: - View Protocol
extension AddAddressViewController : AddAddressViewProtocol {
    func addAddressButtonTapped(addressName: String, address: String) {
        addressViewModel.updateAddressList(addressName: addressName, Address: address, addOrDelete: true)
    }
    
    func dissmisButtonTapped() {
        dismiss(animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
}
// MARK: - ViewModel Protocol
extension AddAddressViewController : AddressViewModelProtocol {
    func didError(_ error: String) {
        GeneralPopup.showPopup(vc: self, image: .error, title: "Error", subtitle: error, buttonText: "Ok")
    }
    
    func didUpdateAddressSuccessful() {
        self.addAddressView.addressTableView.reloadData()
        self.addAddressView.inputClear()
    }
    
}

// MARK: - UITableView Methods
extension AddAddressViewController : UITableViewDelegate,UITableViewDataSource {
    func setTableViewDelegates() {
        addAddressView.addressTableView.delegate = self
        addAddressView.addressTableView.dataSource = self
        addAddressView.addressTableView.rowHeight = 60
        addAddressView.addressTableView.separatorStyle = .singleLine
        addAddressView.addressTableView.isEditing = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addressViewModel.myPickerDataUnified.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = addressViewModel.myPickerDataUnified[indexPath.row]
        cell.textLabel?.numberOfLines = 3
        cell.textLabel?.frame = CGRect(x: 0, y: 0, width: ScreenSize.widht, height: 50)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let addressName =  self.addressViewModel.myPickerDataAdressName[indexPath.row]
            self.addressViewModel.updateAddressList(addressName: addressName, Address: "", addOrDelete: false)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if addressViewModel.myPickerDataUnified.count < 1 {
            return "No Registered Address"
        } else {
            return "Registered Addresses"
        }
    }
    
}

// MARK: - UIPickerView methods
extension AddAddressViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    private func setupPickerDelegates() {
        addAddressView.thePicker.delegate = self
        addAddressView.thePicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addressViewModel.cityList.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return addressViewModel.cityList[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.addAddressView.addressCityTextField.text = addressViewModel.cityList[row]
        self.view.endEditing(true)
    }
    
}

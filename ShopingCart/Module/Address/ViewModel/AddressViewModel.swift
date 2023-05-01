//
//  AddressViewModel.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 20.03.2023.
//

import Kingfisher
import Firebase
import FirebaseAuth
import FirebaseFirestore
import UIKit

//MARK: Protocols
protocol AddressViewModelProtocol: AnyObject {
    func didError(_ error: String)
    func didUpdateAddressSuccessful()
}

final class AddressViewModel {
    
    weak var delegate : AddressViewModelProtocol?
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    private let service : WebService = WebService()
    
    var myPickerDataAdressName : [String] = []
    var myPickerDataUnified : [String] = []
    var myPickerData:[String:String] = [:]
    
    var cityList : [String] = []
    
    //MARK: Address Func
    func updateAddressList(addressName: String, Address: String,addOrDelete : Bool) {
        guard let currentUser = currentUser else { return }
        let userRef = database.collection("Users").document(currentUser.uid)
        
        if addOrDelete {
            userRef.updateData(["addressList.\(addressName):":Address]) { error in
                if let error = error {
                    self.delegate?.didError(error.localizedDescription)
                } else {
                    self.delegate?.didUpdateAddressSuccessful()
                }
            }
        } else {
            userRef.updateData(["addressList.\(addressName)":FieldValue.delete()]) { error in
                if let error = error {
                    self.delegate?.didError(error.localizedDescription)
                } else {
                    self.delegate?.didUpdateAddressSuccessful()
                }
            }
        }
        fetchAddressList()
    }
    
    func fetchAddressList() {
        guard let currentUser = currentUser else { return }
        let addressListRef = database.collection("Users").document(currentUser.uid)
        addressListRef.getDocument(source: .default) { [self] documentData, error in
            myPickerDataUnified.removeAll()
            myPickerDataAdressName.removeAll()
            if let documentData = documentData {
                self.myPickerData = (documentData.get("addressList") as? [String: String])!
                for i in myPickerData {
                    let Unified = i.key + " " + i.value
                    myPickerDataUnified.append(Unified)
                    myPickerDataAdressName.append(i.key)
                }
                self.delegate?.didUpdateAddressSuccessful()
            }
        }
    }
    
    func fetchCityList() {
        service.fetchCity { response in
            guard let citys = response?.cityDetail else {return}
            for i in citys {
                self.cityList.append(i.name ?? "Unknown")
            }
        } onFail: { error in
            self.delegate?.didError(error?.localizedDescription ?? "error")
        }
    }
}

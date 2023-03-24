//
//  ProductDetailViewModel.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 19.03.2023.
//

import Kingfisher
import Firebase
import FirebaseAuth
import FirebaseFirestore
import UIKit

//MARK: Protocols
protocol ProductDetailViewModelProtocol: AnyObject {
    func didError(_ error: String)
    func didProductsSuccessful()
    func didUpdateSuccessful(productCount : Int)
    func didFavStatusSuccessful(fav:Bool)
    func didAddressApendSuccessful()
}

class ProductDetailViewModel {
    
    weak var delegate : ProductDetailViewModelProtocol?
    weak var viewController : ProductDetailViewController!
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    
    var keys = [String]()
    var favStatus : Bool?
    var myPickerDataUnified : [String] = []
    var myPickerDataKey : [String] = []
    var myPickerData:[String:String] = [:]
    
    func shareProduct(id : String) {
        guard let url = URL(string: "https://fakestoreapi.com/products/\(id)") else { return }
        let items = [ url ]
        let activityViewController = UIActivityViewController(activityItems: items , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.viewController.view
        self.viewController.present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: Recently Func
    func addRecentlyProduct(productId: Int) {
        guard let currentUser = currentUser else { return }
        let userRef = database.collection("Users").document(currentUser.uid)
        userRef.updateData(["recentlyList.\(productId)":true]) { error in
            if let error = error {
                print("error")
            } else {
                print("success")
            }
        }
    }
    
    //MARK: Cart Func
    func updateCartProduct(productId: Int, count: Int) {
        guard let currentUser = currentUser else { return }
        let userRef = database.collection("Users").document(currentUser.uid)
        if count > 0 {
            userRef.updateData(["cart.\(productId)":count]) { error in
                if let error = error {
                    self.delegate?.didError(error.localizedDescription)
                } else {
                    self.delegate?.didUpdateSuccessful(productCount: count)
                }
            }
        } else {
            userRef.updateData(["cart.\(productId)":FieldValue.delete()]) { error in
                if let error = error {
                    self.delegate?.didError(error.localizedDescription)
                } else {
                    self.delegate?.didUpdateSuccessful(productCount: count)
                }
            }
        }
    }
    
    //MARK: Favori Func
    
    func updateFavoriProduct(productId: Int, fav: Bool) {
        guard let currentUser = currentUser else { return }
        let userRef = database.collection("Users").document(currentUser.uid)
        
        if fav {
            userRef.updateData(["favList.\(productId)":fav]) { error in
                if let error = error {
                    self.delegate?.didError(error.localizedDescription)
                } else {
                    self.delegate?.didProductsSuccessful()
                }
            }
        } else {
            userRef.updateData(["favList.\(productId)":FieldValue.delete()]) { error in
                if let error = error {
                    self.delegate?.didError(error.localizedDescription)
                } else {
                    self.delegate?.didProductsSuccessful()
                }
            }
        }
    }
    
    func favStatus(productId:Int) {
        guard let currentUser = currentUser else { return }
        let favListRef = database.collection("Users").document(currentUser.uid)
        favListRef.getDocument(source: .default) { [self] documentData, error in
            if let documentData = documentData {
                self.favStatus = nil
                for i in (documentData.get("favList") as? [String: Bool])!.keys {
                    if i == "\(productId)" {
                        self.favStatus = true
                        break
                    }
                }
                self.delegate?.didFavStatusSuccessful(fav: favStatus ?? false)
            }
            
        }
    }
    
    
    //MARK: Address Func
    func fetchAddressList() {
        myPickerDataUnified.removeAll()
        myPickerDataKey.removeAll()
        guard let currentUser = currentUser else { return }
        let addressListRef = database.collection("Users").document(currentUser.uid)
        addressListRef.getDocument(source: .default) { [self] documentData, error in
            if let documentData = documentData {
                self.myPickerData = (documentData.get("addressList") as? [String: String])!
                for i in myPickerData {
                    let Unified = i.key + " " + i.value
                    myPickerDataKey.append(i.key)
                    myPickerDataUnified.append(Unified)
                    self.delegate?.didAddressApendSuccessful()
                    
                }
            }
        }
        self.delegate?.didAddressApendSuccessful()
    }
    
}

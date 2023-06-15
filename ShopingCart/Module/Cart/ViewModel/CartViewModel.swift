//
//  CartViewModel.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 21.03.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol CartViewModelProtocol: AnyObject {
    func didError(_ error: String)
    func didFetchCartList()
    func didPlusOrMinusSuccessful()
    func didProductDeleteSuccessful()
}

final class CartViewModel {
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    weak var delegate: CartViewModelProtocol?
    private let service : WebService = WebService()
    
    var cartProducts = [Product]()
    var cartKeys = [String]()
    var cartKeyAndValue = [String:Int]()
    
    
    //MARK: Cart Func
    func updateCartProduct(productId: Int, count: Int) {
        guard let currentUser = currentUser else { return }
        let userRef = COLLECTİON_USERS.document(currentUser.uid)
        
        if count > 0 {
            userRef.updateData(["cart.\(productId)":count]) { error in
                if let error = error {
                    self.delegate?.didError(error.localizedDescription)
                } else {
                    self.cartKeyAndValue["\(productId)"] = count
                    self.delegate?.didPlusOrMinusSuccessful()
                    
                }
            }
        } else {
            userRef.updateData(["cart.\(productId)":FieldValue.delete()]) { error in
                if let error = error {
                    self.delegate?.didError(error.localizedDescription)
                } else {
                    self.delegate?.didProductDeleteSuccessful()
                }
            }
        }
    }
    
    
    func fetchCartList() {
        guard let currentUser = currentUser else { return }
        let cartListRef = COLLECTİON_USERS.document(currentUser.uid)
        cartListRef.getDocument(source: .default) { [self] documentData, error in
            if let documentData = documentData {
                self.cartKeyAndValue = (documentData.get("cart") as? [String: Int])!
                self.cartKeys.removeAll()
                for i in cartKeyAndValue {
                    cartKeys.append(i.key)
                }
                self.fetchCartProducts(productIds: cartKeys)
            }
        }
    }
    
    
    func fetchCartProducts(productIds : [String]) {
        self.cartProducts.removeAll()
        for id in productIds {
            service.productsId(id: Int(id) ?? 1) { reponse in
                self.cartProducts.append(reponse!)
                self.delegate?.didFetchCartList()
            } onFail: { error in
                self.delegate?.didError(error?.localizedDescription ?? "error")
            }
        }
        
        self.delegate?.didFetchCartList()
        
    }
}

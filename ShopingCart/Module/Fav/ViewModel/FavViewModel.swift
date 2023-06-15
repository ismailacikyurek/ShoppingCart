//
//  FavViewModel.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 18.03.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

//MARK: Protocols
protocol FavViewModelProtocol: AnyObject {
    func didError(_ error: String)
    func didProductsSuccessful()
}

final class FavViewModel {
    
    weak var delegate: FavViewModelProtocol?
    private let service : WebService = WebService()
    var favProducts = [Product]()
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    var favList = ["" : false]
    
    //MARK: Favori Func
    func updateFavoriProduct(productId: Int, fav: Bool) {
        guard let currentUser = currentUser else { return }
        let userRef = COLLECTİON_USERS.document(currentUser.uid)
        
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
    
    
    func fetchFavList() {
        guard let currentUser = currentUser else { return }
        let favListRef = COLLECTİON_USERS.document(currentUser.uid)
        favListRef.getDocument(source: .default) { [self] documentData, error in
            if let documentData = documentData {
                self.favList = (documentData.get("favList") as? [String: Bool])!
                self.fetchFavoriProduct(favList: favList)
            }
        }
    }
    
    func fetchFavoriProduct(favList : [String:Bool]) {
        self.favProducts.removeAll()
        for i in favList.keys {
            guard let id = Int(i) else {return}
            service.productsId(id: id) { success in
                self.favProducts.append(success!)
                self.delegate?.didProductsSuccessful()
            } onFail: { error in
                self.delegate?.didError(error?.localizedDescription ?? "error")
            }
        }
        
    }
}


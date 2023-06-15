//
//  RecentlyViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 18.03.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

//MARK: Protocols
protocol RecentlyViewModelProtocol: AnyObject {
    func didError(_ error: String)
    func didProductsSuccessful()
}

final class RecentlyViewModel {
    
    weak var delegate: RecentlyViewModelProtocol?
    private let service : WebService = WebService()
    var recentlyProducts = [Product]()
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    var recentlyList = ["" : false]
    
    //MARK: Recently Func
    func deleteRecentlyProduct(productId: Int) {
        guard let currentUser = currentUser else { return }
        let userRef = COLLECTİON_USERS.document(currentUser.uid)
        
        userRef.updateData(["recentlyList.\(productId)":FieldValue.delete()]) { error in
            if let error = error {
                self.delegate?.didError(error.localizedDescription)
            } else {
                self.delegate?.didProductsSuccessful()
            }
        }
    }
    
    func fetchRecentlyList() {
        guard let currentUser = currentUser else { return }
        let recentlyListRef = COLLECTİON_USERS.document(currentUser.uid)
        recentlyListRef.getDocument(source: .default) { [self] documentData, error in
            if let documentData = documentData {
                self.recentlyList = (documentData.get("recentlyList") as? [String: Bool])!
                self.fetchRecentlyProduct(recentlyList: recentlyList)
            }
        }
    }
    
    func fetchRecentlyProduct(recentlyList : [String:Bool]) {
        self.recentlyProducts.removeAll()
        for i in recentlyList.keys {
            guard let id = Int(i) else {return}
            service.productsId(id: id) { success in
                self.recentlyProducts.append(success!)
                self.delegate?.didProductsSuccessful()
            } onFail: { error in
                self.delegate?.didError(error?.localizedDescription ?? "error")
            }
        }
        self.delegate?.didProductsSuccessful()
    }
}

//
//  HomeViewModel.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 13.03.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol HomeViewModelProtocol: AnyObject {
    func didError(_ error: String)
    func didProductsSuccessful()
    func didCampaignProdcutSuccessful()
    func didFavoriProductSuccessful()
}

final class HomeViewModel {
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    weak var delegate: HomeViewModelProtocol?
    private let service : WebService = WebService()
    var products = [Product]()
    var campaingProducts = [Product]()
    var favList = ["" : false]
    
    func allFetchProducts() {
        service.allProducts { response in
            self.products = response!
            self.delegate?.didProductsSuccessful()
            self.allFetchCampaingProducts()
        } onFail: { error in
            self.delegate?.didError(error?.localizedDescription ?? "")
        }
    }
    
    
    func allFetchCampaingProducts() {
        let campaign = self.products
        self.campaingProducts.removeAll()
        for i in campaign {
            if i.id! % 4 == 0 {
                self.campaingProducts.append(i)
            }
        }
        self.delegate?.didCampaignProdcutSuccessful()
    }
    
    //MARK: Favori Func
    func updateFavoriProduct(productId: Int, fav: Bool) {
        guard let currentUser = currentUser else { return }
        let userRef = COLLECTİON_USERS.document(currentUser.uid)
        
        if fav {
            userRef.updateData(["favList.\(productId)":fav]) { error in
                if error != nil {
                    print("error")
                } else {
                    print("SuccessFul")
                }
            }
        } else {
            userRef.updateData(["favList.\(productId)":FieldValue.delete()]) { error in
                if error != nil {
                    print("error")
                } else {
                    print("SuccessFul")
                }
            }
        }
    }
    
    
    func fetchFavList() {
        guard let currentUser = currentUser else { return }
        let favListRef = COLLECTİON_USERS.document(currentUser.uid)
        favListRef.getDocument(source: .default) { documentData, error in
            if let documentData = documentData {
                self.favList = (documentData.get("favList") as? [String: Bool] ?? ["0":false])
            }
        }
    }
    
}


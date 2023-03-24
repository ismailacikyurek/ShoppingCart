//
//  ProductListViewModel.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 13.03.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol ProductListViewModelProtocol: AnyObject {
    func didError(_ error: String)
    func didProductsSuccessful()
}

final class ProductListViewModel {
    
    weak var delegate: ProductListViewModelProtocol?
    private let service : WebService = WebService()
    var products = [Product]()
    var searchResultproducts = [Product]()
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    var favList = ["" : false]
    
    func allFetchProducts() {
        service.allProducts { response in
            self.products = response!
            self.delegate?.didProductsSuccessful()
        } onFail: { error in
            self.delegate?.didError(error?.localizedDescription ?? "")
        }
    }
    
    func getCategoryProducts(category : SelectedCategory) {
        service.category(category: category) { response in
            self.products = response!
            self.delegate?.didProductsSuccessful()
        } onFail: { error in
            self.delegate?.didError(error?.localizedDescription ?? "")
        }
        
    }
    func search(searctext: String, model: [Product]) -> [Product] {
        let searchResult = searctext.isEmpty ? model : model.filter {$0.title?.lowercased().contains(searctext.lowercased()) as! Bool}
        self.searchResultproducts = searchResult
        return searchResultproducts
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
    
    
    func fetchFavList() {
        guard let currentUser = currentUser else { return }
        let favListRef = database.collection("Users").document(currentUser.uid)
        favListRef.getDocument(source: .default) { documentData, error in
            if let documentData = documentData {
                self.favList = (documentData.get("favList") as? [String: Bool])!
            }
        }
    }
}

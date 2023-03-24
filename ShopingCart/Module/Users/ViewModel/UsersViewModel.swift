//
//  AuthViewModel.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 8.03.2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

protocol UsersViewModelProtocol: AnyObject {
    func didError(_ error: Error)
    func didSignUpSuccessful()
    func didSignInSuccessful()
}

final class UsersViewModel {
    weak var delegate: UsersViewModelProtocol?
    private let database = Firestore.firestore()
    
    func register(username: String ,email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { responseAuthData, error in
            if error != nil {
                self.delegate?.didError(error!)
                return
            } else {
                //                self.delegate?.didSignUpSuccessful()
            }
            
            let Request = Auth.auth().currentUser?.createProfileChangeRequest()
            Request?.displayName = username
            Request?.commitChanges { error in
                if let error = error {
                    self.delegate?.didError(error)
                    return
                }
            }
            
            guard let uid = responseAuthData?.user.uid,
                  let email = responseAuthData?.user.email else { return }
            
            let cart: [String: Int] = [:]
            let favList: [String: Bool] = [:]
            let recentlyList: [String: Bool] = [:]
            let addressList: [String: String] = [:]
            
            let user = User(id: uid, username: username, email: email, addressList: addressList, cart: cart, favList: favList,recentlyList: recentlyList)
            
            self.database.collection("Users").document(uid).setData(user.dictionary) { error in
                if let error = error {
                    self.delegate?.didError(error)
                    return
                }
                self.delegate?.didSignUpSuccessful()
            }
        }
    }
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { users, error in
            if error != nil {
                self.delegate?.didError(error!)
                return
            } else {
                self.delegate?.didSignInSuccessful()
            }
        }
    }
}


struct JSON {
    static let encoder = JSONEncoder()
}
extension Encodable {
    var dictionary: [String: Any] {
        let data = (try? JSON.encoder.encode(self)) ?? Data()
        return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
    }
}

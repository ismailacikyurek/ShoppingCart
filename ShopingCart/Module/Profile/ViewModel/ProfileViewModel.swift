//
//  ProfileViewModel.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 8.03.2023.
//


import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

//MARK: Protocols
protocol ProfileViewModelProtocol: AnyObject {
    func didSignOutError(_ error: Error)
    func didSignOutSuccessful()
    func didFetchUserInfo(username : String? ,email : String?)
    func didUploadProfilePhotoSuccessful()
    func didFetchProfilePhotoSuccessful(Url : String?)
}

protocol ProfileViewModelResetPasswordProtocol: AnyObject {
    func didResetPasswordError(_ error: Error)
    func didResetPasswordSuccessful()
}

final class ProfileViewModel {
    weak var delegate: ProfileViewModelProtocol?
    weak var delegateResetPassword: ProfileViewModelResetPasswordProtocol?
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    let storage = Storage.storage().reference()
    private let service : WebService = WebService()
    
    func fetchUser() {
        if let currentUser = currentUser {
            let username = currentUser.displayName
            let email = currentUser.email
            self.delegate?.didFetchUserInfo(username: username, email: email)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.delegate?.didSignOutSuccessful()
        } catch {
            self.delegate?.didSignOutError(error)
        }
    }
    func setProfilePhoto(imageData: Data) {
        if let currentUser = currentUser {
            let profileImageRef = storage.child("profilePhotos/\(currentUser.uid)/photo.png")
            profileImageRef.putData(imageData) { data, error in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    self.delegate?.didUploadProfilePhotoSuccessful()
                }
                
            }
        }
    }
    
    func getProfilePhoto() {
        if let currentUser = currentUser {
            let profileImageRef = storage.child("profilePhotos/\(currentUser.uid)/photo.png")
            profileImageRef.downloadURL { url, error in
                guard let url = url , error == nil else { return }
                let urlString = url.absoluteString
                self.delegate?.didFetchProfilePhotoSuccessful(Url: urlString)
            }
        }
    }
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if  error != nil {
                self.delegateResetPassword?.didResetPasswordError(error!)
            } else {
                self.delegateResetPassword?.didResetPasswordSuccessful()
            }
        }
    }
    
}

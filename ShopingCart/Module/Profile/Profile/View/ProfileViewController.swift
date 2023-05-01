//
//  ProfileViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 4.03.2023.

import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
    
    private let profileView = ProfileView()
    private let profileViewModel = ProfileViewModel()
    
    var profileList : [ProfileList] = []
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = profileView
        profileViewModel.delegate = self
        setTableView()
        navigationController?.isNavigationBarHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileViewModel.fetchUser()
        profileViewModel.getProfilePhoto()
        profileView.profilePhotoViewAnimate()
    }
    
    
}

extension ProfileViewController {
    
    func profileViewOpenGalery() {
        let pickerImage = UIImagePickerController()
        pickerImage.sourceType = .photoLibrary
        pickerImage.delegate = self
        pickerImage.allowsEditing = true
        present(pickerImage, animated: true)
    }
    
}
extension ProfileViewController : ProfileViewModelProtocol {
    func didUploadProfilePhotoSuccessful() {
        profileViewModel.getProfilePhoto()
    }
    
    func didFetchProfilePhotoSuccessful(Url: String?) {
        profileView.profilePhoto.kf.setImage(with:URL(string: Url ?? ""))
        Loading.stopLoading(vc: self)
    }
    
    func didFetchUserInfo(username: String?, email: String?) {
        
        self.profileList = [ProfileList(image: "person",description: username ?? ""),
                            ProfileList(image: "envelope",description: email ?? ""),
                            ProfileList(image: "photo.on.rectangle.angled",description: "Upload Profile Image"),
                            ProfileList(image: "key.viewfinder",description: "Reset Password"),
                            ProfileList(image: "location",description: "My Address"),
                            ProfileList(image: "heart.fill",description: "Favorite Products"),
                            ProfileList(image: "clock",description: "Recently Visited Products"),
                            ProfileList(image: "xmark.circle.fill",description: "Sign Out")]
        profileView.tableView.reloadData()
    }
    
    func didSignOutError(_ error: Error) {
        GeneralPopup.showPopup(vc: self, image: .error, title: "Error", subtitle: error.localizedDescription, buttonText: "Ok")
    }
    
    func didSignOutSuccessful() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC,animated: true)
    }
    
}


// MARK: - UITableView Methods
extension ProfileViewController : UITableViewDelegate,UITableViewDataSource {
    
    func setTableView() {
        profileView.tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        profileView.tableView.delegate = self
        profileView.tableView.dataSource = self
        profileView.tableView.rowHeight = 60
        profileView.tableView.separatorStyle = .singleLine
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        cell.configure(data: profileList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 2 :
            self.profileViewOpenGalery()
        case 3 :
            let resetVc = ResetPasswordViewController()
            resetVc.modalPresentationStyle = .pageSheet
            present(resetVc, animated: true)
        case 4 :
            let addressVc = AddAddressViewController()
            addressVc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(addressVc, animated: true)
        case 5 :
            let favVC = FavViewController()
            favVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(favVC, animated: true)
        case 6 :
            let recentlyVC = RecentlyViewController()
            recentlyVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(recentlyVC, animated: true)
        case 7 :
            AlertMessage.showAlertWithTwoCustomAction(vc: self,
                                                      title: "Are you sure ?",
                                                      message: "Are you sure you want to log out?",
                                                      buttonTitle: "Yes",
                                                      secondButtonTitle: "Cancel") {
                self.profileViewModel.signOut()
            }
        default:
            print("default")
        }
    }
}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        guard let imageData = image.pngData() else { return }
        profileViewModel.setProfilePhoto(imageData: imageData)
        Loading.startLoading(vc: self)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

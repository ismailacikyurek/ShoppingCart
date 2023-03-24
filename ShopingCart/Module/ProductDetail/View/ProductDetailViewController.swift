//
//  ProductDetailViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 13.03.2023.
//

import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {
    
    private let productDetailViewModel = ProductDetailViewModel()
    let productDetailView = ProductDetailView()
    var product : Product?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.tabBarController?.tabBar.isHidden = true
        view = productDetailView
        productDetailView.viewController = self
        productDetailViewModel.viewController = self
        productDetailView.interface = self
        productDetailViewModel.delegate = self
        
        productDetailViewModel.addRecentlyProduct(productId: (product?.id)!)
        productDetailViewModel.favStatus(productId: product?.id! ?? 0)
        productDetailView.configure(data: product)
        setDelegate()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productDetailViewModel.fetchAddressList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
}


extension ProductDetailViewController : ProductDetailViewInterfaceProtocol {
    func backButtonTapped() {
        dismiss(animated: true)
    }
    
    func updateCart(productCount: Int) {
        productDetailViewModel.updateCartProduct(productId: (product?.id)!, count: productCount)
    }
    
    func addNewAddress() {
        let addAddressVC = AddAddressViewController()
        addAddressVC.modalPresentationStyle = .fullScreen
        present(addAddressVC, animated: true)
    }
    
    func favButtonTapped(productId: Int, fav: Bool) {
        productDetailViewModel.updateFavoriProduct(productId: productId, fav: fav)
    }
    
    
    func shareButtonTapped(id:String) {
        productDetailViewModel.shareProduct(id: id)
    }
    
}

extension ProductDetailViewController : ProductDetailViewModelProtocol {
    func didAddressApendSuccessful() {
        if productDetailViewModel.myPickerDataUnified.count > 0 {
            let text = productDetailViewModel.myPickerDataUnified[0]
            let addressName = productDetailViewModel.myPickerDataKey[0]
            self.productDetailView.addressTextField.attributedText = text.underlineAttriStringText(text: text, rangeText1: addressName, rangeText1Font: .Bold_18, rangeText1Color: .mainAppColor,
                                                                                                   rangeText2: "...", rangeText2Font: .Regular_18, rangeText2Color: .black)
        } else {
            productDetailView.addressTextField.text = nil
        }
    }
    
    func didUpdateSuccessful(productCount:Int) {
        var sendProductCount = ["productCount" : productCount,"productId" : product?.id!]
        NotificationCenter.default.post(name: NSNotification.Name("update_cart"), object: nil,userInfo: sendProductCount)
        productDetailView.updateCountLabel(count: productCount)
    }
    
    func didFavStatusSuccessful(fav: Bool) {
        self.productDetailView.fav = fav
        if fav  {
            self.productDetailView.favButton.setImage(UIImage(named: "favorite"), for: .normal)
        } else {
            self.productDetailView.favButton.setImage(UIImage(named: "favoriteEmpty"), for: .normal)
        }
    }
    
    func didError(_ error: String) {
        GeneralPopup.showPopup(vc: self, image: .error, title: "Error", subtitle: error, buttonText: "Ok")
    }
    
    func didProductsSuccessful() {
        self.productDetailViewModel.favStatus(productId: product?.id ?? 0)
    }
    
}
extension ProductDetailViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    func setDelegate() {
        self.productDetailView.thePicker.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return productDetailViewModel.myPickerDataUnified.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return productDetailViewModel.myPickerDataUnified[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let text = productDetailViewModel.myPickerDataUnified[row]
        let addressName = productDetailViewModel.myPickerDataKey[row]
        self.productDetailView.addressTextField.attributedText = text.underlineAttriStringText(text: text, rangeText1: addressName, rangeText1Font: .Bold_18, rangeText1Color: .mainAppColor,
                                                                                               rangeText2: "...", rangeText2Font: .Regular_18, rangeText2Color: .black)
        self.view.endEditing(true)
    }
}

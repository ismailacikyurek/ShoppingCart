//
//  ProductListView.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 13.03.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

protocol ProductListViewInterfaceProtocol: AnyObject {
    func filtreButtonTapped()
}

class ProductListView: UIView {
    
    // MARK: UIComponent
    lazy var searchTextField = UITextField()
    lazy var productCollectionView = UICollectionView()
    lazy var filtreButton = UIButton()
    lazy var noProductImageView = UIImageView()
    
    private let currentUser = Auth.auth().currentUser?.displayName
    weak var interface: ProductListViewInterfaceProtocol?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        addView()
        addTarget()
        layoutUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: AddSubiew,AddTarget,LayoutUI,SetupUI

extension ProductListView : GeneralViewProtocol {
    func addTarget() {
        filtreButton.addTarget(self, action: #selector(filtreButtonTapped), for: .touchUpInside)
        
        let viewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editKeyboard))
        self.addGestureRecognizer(viewGestureRecognizer)
    }
    
    func setupUI() {
        self.backgroundColor = .white
        productCollectionView = CrateCollectionView(backgroundColor: .clear,showsScrollIndicator: false, paging: false, layout: UICollectionViewFlowLayout(), scrollDirection: .vertical)
        searchTextField.createTextField(font: .Regular_15,placeHolder: "Merhaba \(currentUser ?? ""), Ne aramıştın?", cornerRadius: 12, borderWidth: 1, borderColor: UIColor.mainAppColor.cgColor)
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.padding()
        filtreButton.createButton(titleColor: .mainAppColor, image: "filter")
        noProductImageView.createUIImageView(image: UIImage(named: "noProduct"),contentMode: .scaleToFill,zPosition: 2)
        
        noProductImageView.isHidden = true
    }
    
    func layoutUI() {
        searchBarConstraints()
        filtreButtonConstraints()
        productCollectionViewConstraints()
        noProductImageViewConstraints()
    }
    
    func addView() {
        addSubviews(productCollectionView,searchTextField,filtreButton,noProductImageView)
    }
    //MARK: UI Action
    @objc func filtreButtonTapped() {
        interface?.filtreButtonTapped()
    }
}

extension ProductListView {
    //MARK: UI Action
    @objc func editKeyboard() {
        self.endEditing(true)
    }
}

//MARK: Constraints
extension ProductListView  {
    func searchBarConstraints() {
        self.searchTextField.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(70)
            make.leading.equalTo(self.snp.leading).offset(15)
            make.trailing.equalTo(self.snp.trailing).offset(-15)
            make.height.equalTo(35)
        }
    }
    func filtreButtonConstraints() {
        self.filtreButton.snp.makeConstraints { make in
            make.top.equalTo(searchTextField).offset(0)
            make.trailing.equalTo(searchTextField.snp.trailing).offset(-5)
            make.height.width.equalTo(35)
        }
    }
    func productCollectionViewConstraints() {
        self.productCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.equalTo(ScreenSize.height-120)
        }
    }
    func noProductImageViewConstraints() {
        self.noProductImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(ScreenSize.height/2-175)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.height.equalTo(350)
        }
    }
    
}

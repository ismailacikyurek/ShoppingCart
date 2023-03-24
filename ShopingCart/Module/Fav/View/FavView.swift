//
//  FavView.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 18.03.2023.

import UIKit
import SnapKit

//MARK: Protocols
protocol FavViewInterfaceProtocol: AnyObject {
    func dissmisButtonTapped()
}

class FavView: UIView {
    // MARK: UIComponent
    lazy var favoriCollectionView = UICollectionView()
    lazy var backButton = UIButton()
    lazy var title = UILabel()
    lazy var noProductImageView = UIImageView()
    
    weak var interface : FavViewInterfaceProtocol?
    
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

extension FavView : GeneralViewProtocol {
    func setupUI() {
        self.backgroundColor = .white
        favoriCollectionView = CrateCollectionView(backgroundColor: .clear,showsScrollIndicator: false, paging: false, layout: UICollectionViewFlowLayout(), scrollDirection: .vertical)
        backButton.setImage(UIImage.init(named: "backButton"), for: .normal)
        backButton.tintColor = .black
        title.createLabel(text: "My Favorite", textColor: .black, font: .Bold_15, textAlignment: .center)
        
        noProductImageView.createUIImageView(image: UIImage(named: "noProduct"),contentMode: .scaleToFill,zPosition: 2)
    }
    
    func layoutUI() {
        backButtonConstraints()
        titleConstraints()
        favoriCollectionViewConstraints()
        noProductImageViewConstraints()
    }
    
    func addView() {
        addSubviews(favoriCollectionView,backButton,title,noProductImageView)
        
    }
    
    func addTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
}
extension FavView {
    //MARK: UI Action
    @objc func backButtonTapped() {
        interface?.dissmisButtonTapped()
    }
}

//MARK: Constraints
extension FavView {
    func backButtonConstraints() {
        self.backButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(50)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.width.height.equalTo(30)
        }
    }
    func titleConstraints() {
        self.title.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.top).offset(0)
            make.leading.equalTo(self.snp.leading).offset(36)
            make.trailing.equalTo(self.snp.trailing).offset(-36)
            make.height.equalTo(30)
        }
    }
    func favoriCollectionViewConstraints() {
        self.favoriCollectionView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(0)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.equalTo(ScreenSize.height - 40)
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

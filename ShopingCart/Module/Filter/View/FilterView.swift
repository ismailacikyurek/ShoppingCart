//
//  FilterView.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 14.03.2023.
//
//

import UIKit
import SnapKit

//MARK: Protocols
protocol FilterViewInterfaceProtocol: AnyObject {
    func dissmisButtonTapped()
}

class FilterView: UIView {
    // MARK: UIComponent
    lazy var mainView = UIView()
    lazy var titleView = UIView()
    lazy var titleLabel = UILabel()
    lazy var dissmisButton = UIButton()
    lazy var categoryTableView = UITableView()
    
    weak var interface: FilterViewInterfaceProtocol?
    
    var categoryUserInfo = ["selectedCategory" : SelectedCategory.jewelery]
    var category = SelectedCategory.jewelery
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .black.withAlphaComponent(0.5)
        addView()
        addTarget()
        layoutUI()
        setupUI()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: AddSubiew,AddTarget,LayoutUI,SetupUI
extension FilterView : GeneralViewProtocol {
    func addView() {
        addSubviews(mainView,titleView,dissmisButton,categoryTableView)
        titleView.addSubview(titleLabel)
    }
    
    func addTarget() {
        dissmisButton.addTarget(self, action: #selector(dissmisButtonTapped), for: .touchUpInside)
    }
    
    func layoutUI() {
        mainViewConstraints()
        titleViewConstraints()
        titleLabelConstraints()
        dissmisButtonConstraints()
        categoryTableViewConstraints()
    }
    func setupUI() {
        mainView.createView(backgroundColor: .white,cornerRadius: 12,borderColor: UIColor.black.cgColor,borderWidth: 2)
        mainView.removeShadow()
        
        titleView.createView(backgroundColor: .white, cornerRadius: 15, borderColor: UIColor.mainAppColor.cgColor,borderWidth: 2)
        titleView.layer.zPosition = 2
        titleView.removeShadow()
        
        titleLabel.createLabel(text: "Filter", textColor: .mainAppColor, font: .Semibold_18, zPozisition: 3, textAlignment: .center)
        
        dissmisButton.isUserInteractionEnabled = true
        dissmisButton.tintColor = .red
        dissmisButton.contentMode = .scaleToFill
        dissmisButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        
        categoryTableView.layer.zPosition = 3
    }
}

extension FilterView {
    //MARK: UI Action
    @objc func dissmisButtonTapped() {
        interface?.dissmisButtonTapped()
    }
}

//MARK: Constraints
extension FilterView  {
    func mainViewConstraints() {
        self.mainView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(ScreenSize.height-300)
            make.leading.trailing.equalTo(self).offset(0)
            make.height.equalTo(300)
        }
    }
    func titleViewConstraints() {
        self.titleView.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.top).offset(-25)
            make.leading.equalTo(self.snp.leading).offset(50)
            make.trailing.equalTo(self.snp.trailing).offset(-50)
            make.height.equalTo(50)
        }
    }
    func titleLabelConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(titleView).offset(0)
            make.leading.trailing.equalTo(titleView).offset(0)
        }
    }
    func dissmisButtonConstraints() {
        self.dissmisButton.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.top).offset(10)
            make.leading.equalTo(self.snp.leading).offset(15)
            make.width.equalTo(25)
            make.height.equalTo(30)
        }
    }
    func categoryTableViewConstraints() {
        self.categoryTableView.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.top).offset(40)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.equalTo(200)
        }
    }
}


//
//  ProfileView.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 5.03.2023.
//

import UIKit

final class ProfileView: UIView {
    
    // MARK:  UIComponent
    lazy var upView = UIView()
    lazy var usernameLabel = UILabel()
    lazy var profilePhotoView = UIView()
    lazy var profilePhoto = UIImageView()
    lazy var tableView = UITableView()
    let shapeLayer = CAShapeLayer()
    var profileList : [ProfileList] = []
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
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

extension ProfileView : GeneralViewProtocol {
    func addTarget() {}
    
    func setupUI() {
        self.backgroundColor = .white
        upView.createView(backgroundColor: UIColor(patternImage: UIImage(named:"registerBack")!),cornerRadius: 30)
        profilePhotoView.createView(backgroundColor: .white,maskedToBounds: true, cornerRadius: 60,clipsToBounds: true,borderColor: UIColor.white.cgColor,borderWidth: 2)
        profilePhoto.createUIImageView(image: UIImage(named: ""),contentMode: .scaleToFill,zPosition: 2)
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: ScreenSize.widht/2, y: ScreenSize.height/7+8), radius: 60, startAngle: 0, endAngle: 2*CGFloat(CFloat.pi), clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.fastDeliveryColor.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
    }
    
    func layoutUI() {
        upViewConstraints()
        profilePhotoViewConstraints()
        profilePhotoConstraints()
        tableViewConstraints()
    }
    
    func addView() {
        addSubviews(upView,profilePhotoView,tableView)
        profilePhotoView.addSubview(profilePhoto)
        self.layer.addSublayer(shapeLayer)
        
    }
}

extension ProfileView {
    func profilePhotoViewAnimate() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 3
        shapeLayer.add(animation,forKey: "animation")
    }
}
//MARK: Constraints
extension ProfileView {
    func upViewConstraints() {
        self.upView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(-20)
            make.leading.equalTo(self.snp.leading).offset(0)
            make.trailing.equalTo(self.snp.trailing).offset(0)
            make.height.equalTo(ScreenSize.height/3 + 20)
        }
        
    }
    func profilePhotoViewConstraints() {
        self.profilePhotoView.snp.makeConstraints { make in
            make.top.equalTo(upView.snp.centerY).offset(-60)
            make.leading.equalTo(upView.snp.centerX).offset(-60)
            make.height.width.equalTo(120)
        }
        
    }
    func profilePhotoConstraints() {
        self.profilePhoto.snp.makeConstraints { make in
            make.top.bottom.equalTo(profilePhotoView).offset(0)
            make.leading.trailing.equalTo(profilePhotoView).offset(0)
        }
        
    }
    func tableViewConstraints() {
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(upView.snp.bottom).offset(0)
            make.leading.trailing.equalTo(self).offset(0)
            make.trailing.equalTo(self.snp.trailing).offset(0)
            make.height.equalTo(ScreenSize.height/1.5)
        }
    }
}

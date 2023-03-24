//
//  ProfileTableViewCell.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 9.03.2023.
//

import UIKit
import SnapKit

class ProfileTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileCell"
    
    // MARK: UIComponent
    lazy var symbolImage = UIImageView()
    lazy var descLabel = UILabel()
    
    var image : String?
    var descText : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addView()
        setupUI()
        layoutUI()
        
    }
    func configure(data: ProfileList) {
        self.image = data.image
        self.descText = data.description
    }
}


//MARK: AddSubiew,AddTarget,LayoutUI,SetupUI

extension ProfileTableViewCell : GeneralViewProtocol {
    func addTarget() {}
    
    func setupUI() {
        symbolImage.createUIImageView(image: UIImage(systemName: image ?? ""),tintColor: .black,contentMode: .scaleToFill)
        descLabel.createLabel(text: descText,textColor: .black, font: .Bold_18, numberOfLines: 3, textAlignment: .left)
        if descText == "Sign Out" {
            descLabel.textColor = .red
            descLabel.font = .Semibold_18
            symbolImage.tintColor = .red
        }
    }
    
    func layoutUI() {
        symbolImageConstraints()
        descLabelConstraints()
    }
    
    func addView() {
        addSubviews(symbolImage, descLabel)
    }
    
}
//MARK: Constraints
extension ProfileTableViewCell{
    private func symbolImageConstraints() {
        symbolImage.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(17)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.width.equalTo(30)
            make.height.equalTo(25)
        }
    }
    
    private func descLabelConstraints() {
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(symbolImage.snp.top).offset(-2)
            make.leading.equalTo(symbolImage.snp.trailing).offset(15)
            make.width.equalTo(220)
            make.height.equalTo(30)
        }
    }
}

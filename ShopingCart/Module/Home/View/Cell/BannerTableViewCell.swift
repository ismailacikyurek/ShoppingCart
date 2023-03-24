//
//  BannerTableViewCell.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 11.03.2023.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    
    static let identifier = "BannerCell"
    
    let photoImageView : UIImageView = {
        let x = UIImageView()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.frame = CGRect(x: 3, y: 34, width: ScreenSize.widht-15, height: 110)
        x.contentMode = .scaleToFill
        x.layer.masksToBounds = true
        x.layer.cornerRadius = 13
        return x
    }()
    
    let bannerTitle : UILabel = {
        let x = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.frame = CGRect(x: 4, y: 2, width: ScreenSize.widht-15, height: 30)
        x.textColor = .black
        x.backgroundColor = .clear
        x.font = .Bold_18
        return x
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = .clear
        self.selectedBackgroundView?.backgroundColor = .clear
    }
    
    func configure(data : BannerModel) {
        self.addSubview(photoImageView)
        self.addSubview(bannerTitle)
        photoImageView.image = data.image
        bannerTitle.text = data.title
    }

}

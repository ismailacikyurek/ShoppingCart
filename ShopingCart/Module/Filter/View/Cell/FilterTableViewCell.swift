//
//  FilterTableViewCell.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 14.03.2023.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    static let identifier = "FilterCell"
    // MARK: - UI Component
    let categoryNameLabel : UILabel = {
        let x = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.frame = CGRect(x: 20, y: 2, width: 180, height: 30)
        x.textColor = .black
        x.textAlignment = .left
        x.font = .Regular_18
        return x
    }()
    let categoryCountLabel : UILabel = {
        let x = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.frame = CGRect(x: ScreenSize.widht - 70, y: 2, width: 30, height: 30)
        x.textColor = .mainAppColor
        x.textAlignment = .right
        x.font = .Bold_18
        return x
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = .white
        self.selectedBackgroundView?.backgroundColor = .clear
        self.addSubview(categoryCountLabel)
        self.addSubview(categoryNameLabel)
    }
    
    func configure(data : CategoryModel) {
        categoryNameLabel.text = data.categoryName
        categoryCountLabel.text = "\(data.categoryCount!)"
    }
    
}


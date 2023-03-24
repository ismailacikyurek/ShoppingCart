//
//  SliderCollectionViewCell.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 10.03.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class SliderCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Cell's Identifier
    
    static let identifier = "SliderCell"
    
    // MARK: UIComponent
    lazy var campaignProductsLabel = UILabel()
    lazy var sliderImage = UIImageView()
    lazy var sliderTitleLabel = UILabel()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setupUI()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func configure(data: Product) {
        sliderImage.kf.setImage(with:URL(string: data.image ?? ""))
        sliderTitleLabel.text = data.title
    }
}


//MARK: AddSubiew,AddTarget,LayoutUI,SetupUI

extension SliderCollectionViewCell : GeneralViewProtocol {
    func addTarget() {}
    
    func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        sliderImage.createUIImageView(image: UIImage(named: ""),
                                      tintColor: .orange,
                                      backgroundColor: .clear,
                                      contentMode: .scaleToFill,
                                      isUserInteractionEnabled: true)
        
        sliderTitleLabel.createLabel(text: "", backgroundColor: .clear,
                                     textColor: .black, font: .Bold_24,
                                     zPozisition: 1,
                                     numberOfLines: 2,
                                     textAlignment: .center)
        campaignProductsLabel.createLabel(text: "Campaign Products",
                                          backgroundColor: .clear, textColor: .black,
                                          font: .Bold_14, zPozisition: 1,
                                          numberOfLines: 1,
                                          textAlignment: .left)
    }
    
    
    func layoutUI() {
        campaignProductsLabelConstraint()
        sliderImageConstraint()
        sliderTitleLabelConstraint()
    }
    
    func addView() {
        addSubviews(campaignProductsLabel,sliderImage, sliderTitleLabel)
    }
    
}


//MARK: Constraints
extension SliderCollectionViewCell {
    private func campaignProductsLabelConstraint() {
        campaignProductsLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(1)
            make.leading.equalTo(self.snp.leading).offset(1)
        }
    }
    
    private func sliderImageConstraint() {
        sliderImage.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-50)
            make.width.equalTo(120)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
        }
    }
    
    private func sliderTitleLabelConstraint() {
        sliderTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(sliderImage)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(sliderImage.snp.leading).offset(-10)
        }
    }
}

//
//  OnBoardingCollectionViewCell.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 6.03.2023.
//
import UIKit
import SnapKit

final class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Cell's Identifier
    
    static let identifier = "OnboardingCell"
    
    // MARK: UIComponent
    lazy var onboardingImage = UIImageView()
    lazy var slideTitleLbl = UILabel()
    lazy var slideDescLbl = UILabel()
    
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
    
    func configure(data: onBoardingModel) {
        onboardingImage.image = data.Image
        slideTitleLbl.text = data.title
        slideDescLbl.text = data.description
    }
}

//MARK: AddSubiew,AddTarget,LayoutUI,SetupUI

extension OnBoardingCollectionViewCell : GeneralViewProtocol {
    func addTarget() {}
    
    func setupUI() {
        onboardingImage.createUIImageView(image: UIImage(named: ""),
                                          tintColor: .orange,
                                          backgroundColor: .white,
                                          contentMode: .scaleAspectFit,
                                          isUserInteractionEnabled: false)
        
        slideTitleLbl.createLabel(text: "",
                                  backgroundColor: .clear,
                                  textColor: .systemGray,
                                  font: .Bold_24,
                                  numberOfLines: 2,
                                  textAlignment: .center)
        slideDescLbl.createLabel(text: "",
                                 backgroundColor: .clear,
                                 textColor: .black,
                                 font: .Regular_16,
                                 numberOfLines: 3,
                                 textAlignment: .center)
    }
    
    
    func layoutUI() {
        onboardinImageConstraint()
        slideTitleLblConstraint()
        slideDescLblConstraint()
    }
    
    func addView() {
        addSubviews(onboardingImage, slideTitleLbl, slideDescLbl)
    }
    
    
}
//MARK: Constraints
extension OnBoardingCollectionViewCell {
    private func onboardinImageConstraint() {
        onboardingImage.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(slideTitleLbl.snp.top)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    private func slideTitleLblConstraint() {
        slideTitleLbl.snp.makeConstraints { make in
            make.height.equalTo(82)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.bottom.equalTo(slideDescLbl.snp.top)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    private func slideDescLblConstraint() {
        slideDescLbl.snp.makeConstraints { make in
            make.height.equalTo(82)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
}

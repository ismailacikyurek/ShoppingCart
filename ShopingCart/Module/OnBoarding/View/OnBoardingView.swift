//
//  OnBoardingView.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 6.03.2023.
//

import UIKit
import SnapKit

//MARK: Protocols
protocol OnboardingViewInterface: AnyObject {
    func onboardingViewSkipButtonTapped()
}

class OnBoardingView: UIView {
    // MARK: UIComponent
    lazy var MainView = UIView()
    lazy var skipButton = UIButton()
    lazy var pageControl = UIPageControl()
    lazy var slidesCollectionView = CrateCollectionView(backgroundColor: .white,showsScrollIndicator: false, paging: true, layout: UICollectionViewFlowLayout(), scrollDirection: .horizontal)
    
    weak var interface: OnboardingViewInterface?
    var slidesModel: [onBoardingModel] = []
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        addView()
        addTarget()
        layoutUI()
        setSlides()
        pageControl.numberOfPages = slidesModel.count
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var currentIndex = 0 {
        didSet {
            pageControl.currentPage = currentIndex
            if currentIndex == slidesModel.count - 1 {
                skipButton.setTitle("Sign Up", for: .normal)
            } else {
                skipButton.setTitle("Contiune", for: .normal)
            }
        }
    }
    
    //MARK: - SetSlides
    
    func setSlides() {
        slidesModel = [onBoardingModel(title: "One-click access to thousands of products",
                                       Image: UIImage(named: "main"),
                                       description: "You can find the most suitable product among thousands of categories, colors, sizes and brands."),
                       onBoardingModel(title: "List your favorite products",
                                       Image: UIImage(named: "fav"),
                                       description: "You can see the products suitable for you on a single page by adding them to your favorites."),
                       onBoardingModel(title: "Fast and secure payment",
                                       Image: UIImage(named: "payment"),
                                       description: "You can pay securely with credit card, money order and eft.")]
        
    }
    
    
}

//MARK: AddSubiew,AddTarget,LayoutUI,SetupUI

extension OnBoardingView : GeneralViewProtocol {
    func setupUI() {
        self.backgroundColor = .white
        skipButton.createButton(title: "Contiune",backgroundColor: .mainAppColor,titleColor: .white,font: .Semibold_18,cornerRadius: 20)
        pageControl.createPageControl(pageIndicatorTintColor: .gray,currentPageIndicatorTintColor: .orange,contentMode: .scaleToFill)
    }
    
    func layoutUI() {
        slidesCollectionConstraints()
        pageControlConstraints()
        skipButtonConstraints()
    }
    
    func addView() {
        addSubviews(slidesCollectionView,pageControl,skipButton,MainView)
        
    }
    
    func addTarget() {
        skipButton.addTarget(self, action:#selector(skipButtonTapped), for: .touchUpInside)
    }
}

extension OnBoardingView {
    //MARK: UI Action
    @objc func skipButtonTapped() {
        if currentIndex == slidesModel.count - 1 {
            interface?.onboardingViewSkipButtonTapped()
        } else {
            self.currentIndex += 1
            slidesCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentIndex
        }
    }
}

//MARK: Constraints
extension OnBoardingView {
    func slidesCollectionConstraints() {
        self.slidesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(60)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
            make.height.equalTo(380)
        }
    }
    func pageControlConstraints() {
        self.pageControl.snp.makeConstraints { make in
            make.top.equalTo(slidesCollectionView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(slidesCollectionView).offset(0)
            make.height.equalTo(15)
        }
    }
    func skipButtonConstraints() {
        self.skipButton.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(20)
            make.leading.equalTo(slidesCollectionView.snp.leading).offset(0)
            make.trailing.equalTo(slidesCollectionView.snp.trailing).offset(0)
            make.height.equalTo(50)
            
        } }
}

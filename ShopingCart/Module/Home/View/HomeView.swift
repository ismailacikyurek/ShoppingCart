//
//  HomeView.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 10.03.2023.
//

import UIKit
import FirebaseAuth
import SnapKit

protocol HomeViewInterfaceProtocol: AnyObject {
    func goToProductListViewController()
}

class HomeView: UIView {
    
    // MARK: UIComponent
    lazy var sliderCollectionView = UICollectionView()
    lazy var bannerTableView = UITableView()
    lazy var pageController = UIPageControl()
    lazy var searchTextField = UITextField()
    lazy var categoryCollectionView = UICollectionView()
    lazy var productCollectionView = UICollectionView()
    lazy var categoryMainView = UIView()
    lazy var scrollView = UIScrollView()
    lazy var customView = UIView()
    
    private let currentUser = Auth.auth().currentUser?.displayName
    weak var interface: HomeViewInterfaceProtocol?
    var currentIndex = 0
    var timer : Timer?
    
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

extension HomeView : GeneralViewProtocol {
    func addTarget() {}
    
    func setupUI() {
        self.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
        sliderCollectionView = CrateCollectionView(backgroundColor: .clear,showsScrollIndicator: false, paging: false, layout: UICollectionViewFlowLayout(), scrollDirection: .horizontal)
        sliderCollectionView.layer.cornerRadius = 20
        productCollectionView = CrateCollectionView(backgroundColor: .white,showsScrollIndicator: false, paging: false, layout: UICollectionViewFlowLayout(), scrollDirection: .horizontal)
        pageController.createPageControl(pageIndicatorTintColor: .orange,currentPageIndicatorTintColor: .gray,contentMode: .scaleToFill,backgroundColor: .red)
        pageController.layer.zPosition = 2
        searchTextField.createTextField(font: .Regular_14,placeHolder: "Hello \(currentUser ?? ""), what were you looking for?", cornerRadius: 12, borderWidth: 1, borderColor: UIColor.mainAppColor.cgColor)
        searchTextField.delegate = self
        searchTextField.padding()
        bannerTableView.backgroundColor = .clear
    }
    
    func layoutUI() {
        scrollViewConstraints()
        contentViewConstraints()
        
        sliderCollectionViewConstraints()
        pageControllerConstraints()
        searchBarConstraints()
        productCollectionViewConstraints()
        bannerTableViewConstraints()
    }
    
    func addView() {
        addSubview(scrollView)
        scrollView.addSubview(customView)
        customView.addSubviews(sliderCollectionView,pageController,searchTextField,bannerTableView,productCollectionView)
    }
}

extension HomeView  {
    func startTimer() {
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(pageCurrentToIndex), userInfo: nil, repeats: true)
        }
    }
    //MARK: UI Action
    @objc func pageCurrentToIndex() {
        if currentIndex == 4 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
        pageController.currentPage = currentIndex
        sliderCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension HomeView : UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text == "" {
            } else {
            searchTextField.text = ""
            interface?.goToProductListViewController()
        }
        
    }
}

//MARK: Constraints
extension HomeView  {
    private func scrollViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func contentViewConstraints() {
        customView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(950)
        }
    }
    func sliderCollectionViewConstraints() {
        self.sliderCollectionView.snp.makeConstraints { make in
            make.top.equalTo(scrollView).offset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.equalTo(180)
        }
    }
    func productCollectionViewConstraints() {
        self.productCollectionView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(240)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.equalTo(180)
        }
        
    }
    func pageControllerConstraints() {
        self.pageController.snp.makeConstraints { make in
            make.top.equalTo(sliderCollectionView.snp.bottom).offset(-20)
            make.leading.trailing.equalTo(self).offset(0)
            make.height.equalTo(20)
        }
    }
    
    func searchBarConstraints() {
        self.searchTextField.snp.makeConstraints { make in
            make.top.equalTo(sliderCollectionView.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.height.equalTo(30)
        }
    }
    
    func bannerTableViewConstraints() {
        self.bannerTableView.snp.makeConstraints { make in
            make.top.equalTo(productCollectionView.snp.bottom).offset(5)
            make.leading.equalTo(self).offset(5)
            make.trailing.equalTo(self).offset(-5)
            make.height.equalTo(480)
        }
    }
}

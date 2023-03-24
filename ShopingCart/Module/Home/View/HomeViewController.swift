//
//  HomeViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 4.03.2023.

import UIKit

class HomeViewController: UIViewController {
    
    let homeView = HomeView()
    var bannerModel = [BannerModel(image: UIImage(named: "bannerJeweley"),title: "Jewelry"),
                       BannerModel(image: UIImage(named: "bannerMens"),title: "Men's Clothing"),
                       BannerModel(image: UIImage(named: "bannerWomen"),title: "Women's Clothing"),
                       BannerModel(image: UIImage(named: "bannerElectroins"),title: "Electronic")]
    
    private let homeViewModel = HomeViewModel()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.tabBarController?.tabBar.backgroundColor = .white
        view = homeView
        homeView.interface = self
        homeViewModel.delegate = self
        Loading.startLoading(vc: self)
        setupTableViewDelegate()
        setupDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeViewModel.allFetchProducts()
        self.homeViewModel.fetchFavList()
        self.homeView.searchTextField.isUserInteractionEnabled = true
    }
}

extension HomeViewController : HomeViewInterfaceProtocol {
    func goToProductListViewController() {
        let productListVC = ProductListViewController()
        productListVC.category = .allCategory
        navigationController?.pushViewController(productListVC, animated: true)
    }
}
extension HomeViewController : ProductFavoriCollectionViewProtocol {
    func productFavoriCollectionCell(productId: Int, fav: Bool) {
        self.homeViewModel.updateFavoriProduct(productId: productId, fav: fav)
        self.homeViewModel.fetchFavList()
    }
}

extension HomeViewController : HomeViewModelProtocol {
    func didFavoriProductSuccessful() {
        
    }
    
    func didCampaignProdcutSuccessful() {
        self.homeView.pageController.numberOfPages = homeViewModel.campaingProducts.count
        self.homeView.sliderCollectionView.reloadData()
        homeView.startTimer()
    }
    
    func didError(_ error: String) {
        Loading.stopLoading(vc: self)
        GeneralPopup.showPopup(vc: self, image: .error, title: "Error", subtitle: error, buttonText: "Ok")
    }
    
    func didProductsSuccessful() {
        self.homeView.productCollectionView.reloadData()
    }
}

// MARK: - CollectionView Methods
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupDelegate() {
        homeView.sliderCollectionView.delegate = self
        homeView.sliderCollectionView.dataSource = self
        homeView.sliderCollectionView.register(SliderCollectionViewCell.self, forCellWithReuseIdentifier:SliderCollectionViewCell.identifier)
        
        homeView.productCollectionView.delegate = self
        homeView.productCollectionView.dataSource = self
        homeView.productCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier:ProductCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case homeView.productCollectionView :
            return homeViewModel.products.count
        case homeView.sliderCollectionView :
            return self.homeViewModel.campaingProducts.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case homeView.productCollectionView :
            guard let cell = homeView.productCollectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell()}
            cell.delegate = self
            Loading.stopLoading(vc: self)
            self.homeViewModel.fetchFavList()
            cell.configure(data: homeViewModel.products[indexPath.row], favStatus: homeViewModel.favList )
            return cell
        case homeView.sliderCollectionView :
            guard let cell = homeView.sliderCollectionView.dequeueReusableCell(withReuseIdentifier: SliderCollectionViewCell.identifier, for: indexPath) as? SliderCollectionViewCell else { return UICollectionViewCell()}
            cell.configure(data: homeViewModel.campaingProducts[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailVC = ProductDetailViewController()
        switch collectionView {
        case homeView.productCollectionView : productDetailVC.product = homeViewModel.products[indexPath.row]
        case homeView.sliderCollectionView : productDetailVC.product = homeViewModel.campaingProducts[indexPath.row]
        default:print("")
        }
        productDetailVC.modalPresentationStyle = .overFullScreen
        present(productDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case homeView.productCollectionView :
            return CGSize(width: homeView.productCollectionView.frame.width / 2.8, height: homeView.productCollectionView.frame.height)
        case homeView.sliderCollectionView :
            return CGSize(width: homeView.sliderCollectionView.frame.width, height: homeView.sliderCollectionView.frame.height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case homeView.productCollectionView :
            return 5
        case homeView.sliderCollectionView :
            return 1
        default:
            return 0
        }
    }
}

// MARK: - UITableView Methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableViewDelegate() {
        homeView.bannerTableView.delegate = self
        homeView.bannerTableView.dataSource = self
        homeView.bannerTableView.register(BannerTableViewCell.self, forCellReuseIdentifier: BannerTableViewCell.identifier)
        homeView.bannerTableView.rowHeight = 137
        homeView.bannerTableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bannerModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeView.bannerTableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: indexPath) as! BannerTableViewCell
        cell.configure(data:bannerModel[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productListVC = ProductListViewController()
        switch indexPath.row {
        case 0 : productListVC.category = .jewelery
        case 1 : productListVC.category = .menSClothing
        case 2 : productListVC.category = .womenSClothing
        case 3 : productListVC.category = .electronics
        default: print("")
        }
        navigationController?.pushViewController(productListVC, animated: true)
    }
    
}

extension HomeViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width
        homeView.currentIndex = Int(scrollView.contentOffset.x / witdh)
    }
}

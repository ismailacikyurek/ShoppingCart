//
//  ProductViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 4.03.2023.
//

import UIKit

class ProductListViewController: UIViewController {
    
    var category : SelectedCategory = .allCategory
    let service : WebService = WebService()
    private let productListViewModel = ProductListViewModel()
    let productListView = ProductListView()
    var isSearch = false
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view = productListView
        productListView.interface = self
        productListViewModel.delegate = self
        setupDelegates()
        productListView.searchTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(selectedFilter(_:)),
                                               name: NSNotification.Name(rawValue: "category_filter"),
                                               object: nil) 
        getProducts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productListViewModel.fetchFavList()
    }
}

extension ProductListViewController : ProductListViewModelProtocol {
    func didError(_ error: String) {
        GeneralPopup.showPopup(vc: self, image: .error, title: "Error", subtitle: error, buttonText: "Ok")
    }
    
    func didProductsSuccessful() {
        productListView.productCollectionView.reloadData()
    }
}

extension ProductListViewController : ProductListViewInterfaceProtocol {
    func filtreButtonTapped() {
        let filterVc = FiltreViewController()
        filterVc.modalPresentationStyle = .pageSheet
        present(filterVc, animated: true)
    }
}

extension ProductListViewController {
    func getProducts() {
        if self.category == .allCategory {
            self.productListViewModel.allFetchProducts()
        } else {
            self.productListViewModel.getCategoryProducts(category: category)
        }
    }
    //MARK: UI Action
    @objc func selectedFilter(_ notification: NSNotification) {
        guard let category = notification.userInfo?["selectedCategory"] as? SelectedCategory else {return}
        self.category = category
        getProducts()
    }
}
extension ProductListViewController : ProductFavoriCollectionViewProtocol {
    func productFavoriCollectionCell(productId: Int, fav: Bool) {
        self.productListViewModel.updateFavoriProduct(productId: productId, fav: fav)
        self.productListViewModel.fetchFavList()
    }
}

extension ProductListViewController : UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text!.count > 0 {
            self.productListView.filtreButton.isHidden = true
            self.isSearch = true
            productListViewModel.search(searctext: textField.text!, model: productListViewModel.products)
            self.productListView.productCollectionView.reloadData()
            if productListViewModel.searchResultproducts.isEmpty {
                self.productListView.noProductImageView.isHidden = false
            } else {
                self.productListView.noProductImageView.isHidden = true
            }
        } else {
            self.isSearch = false
            self.productListView.filtreButton.isHidden = false
            self.productListView.noProductImageView.isHidden = true
            self.productListView.productCollectionView.reloadData()
        }
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.isSearch = false
        self.productListView.filtreButton.isHidden = false
        self.productListView.noProductImageView.isHidden = true
        return true
    }
}

// MARK: - CollectionView Methods
extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupDelegates() {
        productListView.productCollectionView.delegate = self
        productListView.productCollectionView.dataSource = self
        productListView.productCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier:ProductCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearch {
            return productListViewModel.searchResultproducts.count
        } else {
            return productListViewModel.products.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isSearch {
            guard let cell = productListView.productCollectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell()}
            cell.delegate = self
            cell.configureProducListVC(data: productListViewModel.searchResultproducts[indexPath.row], favStatus: productListViewModel.favList)
            return cell
        } else {
            guard let cell = productListView.productCollectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell()}
            cell.delegate = self
            cell.configureProducListVC(data: productListViewModel.products[indexPath.row], favStatus: productListViewModel.favList)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let productDetail = ProductDetailViewController()
        if isSearch {
            productDetail.product = productListViewModel.searchResultproducts[indexPath.row]
        } else {
            productDetail.product = productListViewModel.products[indexPath.row]}
        navigationController?.pushViewController(productDetail, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: productListView.productCollectionView.frame.width / 2 - 15, height: productListView.productCollectionView.frame.height/2.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 5)
    }
}

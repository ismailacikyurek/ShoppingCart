//
//  RecentlyViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 18.03.2023.
//

import UIKit
import SnapKit

class RecentlyViewController: UIViewController {
    
    private let recentlyViewModel = RecentlyViewModel()
    let recentlyView = RecentlyView()
    var removedItemIndexNumber: Int = 0
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = recentlyView
        recentlyView.interface = self
        recentlyViewModel.delegate = self
        setupDelegates()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recentlyViewModel.fetchRecentlyList()
    }
}

extension RecentlyViewController : RecentlyViewModelProtocol {
    func didError(_ error: String) {
        GeneralPopup.showPopup(vc: self, image: .error, title: "Error", subtitle: error, buttonText: "Ok")
    }
    
    func didProductsSuccessful() {
        if recentlyViewModel.recentlyProducts.isEmpty {
            recentlyView.noProductImageView.isHidden = false
            recentlyView.recentlyCollectionView.isHidden = true
        } else {
            recentlyView.noProductImageView.isHidden = true
            recentlyView.recentlyCollectionView.isHidden = false
        }
        recentlyView.recentlyCollectionView.reloadData()
    }
}

extension RecentlyViewController : RecentlyViewInterfaceProtocol {
    func dissmisButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}
extension RecentlyViewController : ProductRecentlyCollectionViewProtocol {
    func productRecentlyCollectionCell(productId: Int) {
        self.recentlyViewModel.recentlyProducts.remove(at:removedItemIndexNumber)
        self.recentlyView.recentlyCollectionView.reloadData()
        self.recentlyViewModel.deleteRecentlyProduct(productId: productId)
        
    }
}
// MARK: - CollectionView Methods
extension RecentlyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupDelegates() {
        recentlyView.recentlyCollectionView.delegate = self
        recentlyView.recentlyCollectionView.dataSource = self
        recentlyView.recentlyCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier:ProductCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentlyViewModel.recentlyProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = recentlyView.recentlyCollectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell()}
        cell.delegateRecently = self
        cell.callback = { currentCell in
            self.removedItemIndexNumber = collectionView.indexPath(for: currentCell)!.item
        }
        cell.configureRecently(data: recentlyViewModel.recentlyProducts[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailVC = ProductDetailViewController()
        productDetailVC.product = recentlyViewModel.recentlyProducts[indexPath.row]
        productDetailVC.modalPresentationStyle = .overFullScreen
        present(productDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: recentlyView.recentlyCollectionView.frame.width / 2 - 15, height: recentlyView.recentlyCollectionView.frame.height/3.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 5)
    }
}

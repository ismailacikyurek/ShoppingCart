//
//  FavViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 10.03.2023.
//

import UIKit

class FavViewController: UIViewController {
    
    private let favViewModel = FavViewModel()
    let favView = FavView()
    var removedItemIndexNumber: Int = 0
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = favView
        favView.interface = self
        favViewModel.delegate = self
        setupDelegates()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favViewModel.fetchFavList()
    }
}

extension FavViewController : FavViewModelProtocol {
    func didError(_ error: String) {
        GeneralPopup.showPopup(vc: self, image: .error, title: "Error", subtitle: error, buttonText: "Ok")
    }
    
    func didProductsSuccessful() {
        if favViewModel.favProducts.isEmpty {
            favView.noProductImageView.isHidden = false
            favView.favoriCollectionView.isHidden = true
        } else {
            favView.noProductImageView.isHidden = true
            favView.favoriCollectionView.isHidden = false
        }
        favView.favoriCollectionView.reloadData()
    }
}

extension FavViewController : FavViewInterfaceProtocol {
    func dissmisButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension FavViewController : ProductFavoriCollectionViewProtocol {
    func productFavoriCollectionCell(productId: Int, fav: Bool) {
        self.favViewModel.updateFavoriProduct(productId: productId, fav: fav)
        self.favViewModel.favProducts.remove(at: removedItemIndexNumber)
        favView.favoriCollectionView.reloadData()
    }
}

// MARK: - CollectionView Methods
extension FavViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupDelegates() {
        favView.favoriCollectionView.delegate = self
        favView.favoriCollectionView.dataSource = self
        favView.favoriCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier:ProductCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favViewModel.favProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favView.favoriCollectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell()}
        cell.delegate = self
        cell.configure(data: favViewModel.favProducts[indexPath.row], favStatus: favViewModel.favList)
        cell.callback = { currentCell in
            self.removedItemIndexNumber = collectionView.indexPath(for: currentCell)!.item
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailVC = ProductDetailViewController()
        productDetailVC.product = favViewModel.favProducts[indexPath.row]
        productDetailVC.modalPresentationStyle = .overFullScreen
        present(productDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: favView.favoriCollectionView.frame.width / 2 - 15, height: favView.favoriCollectionView.frame.height/3.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 5)
    }
}

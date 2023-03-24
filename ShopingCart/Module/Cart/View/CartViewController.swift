//
//  CartViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 4.03.2023.

import UIKit

class CartViewController: UIViewController {
    
    private let cartView = CartView()
    private let cartViewModel = CartViewModel()
    var count : Int?
    var totalPrice = 0.0
    var removedItemIndexNumber: Int = 0
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = cartView
        title = "My Cart"
        cartView.interface = self
        cartViewModel.delegate = self
        setupTableDelegates()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cartViewModel.fetchCartList()
        NotificationCenter.default.addObserver(self, selector: #selector(updateCartTable(_:)),
                                               name: NSNotification.Name(rawValue: "update_cart"),
                                               object: nil)
    }
}

extension CartViewController : CartViewInterfaceProtocol {
    func paymentButtonTapped() {
        GeneralPopup.showPopup(vc: self, image: .error, title: "Payment", subtitle: "There is no payment page in this application.", buttonText: "Ok")
    }
    
    func keepShoppingButtonTapped() {
        self.tabBarController?.selectedIndex = 0
    }
}
extension CartViewController : CartTableViewCellProtocol {
    func plusButtonTapped(productId: Int,count: Int) {
        self.cartViewModel.updateCartProduct(productId: productId, count: count)
    }
    
    func minusButtonTapped(productId: Int,count: Int) {
        if count == 0 {
            self.cartViewModel.cartProducts.remove(at: self.removedItemIndexNumber)
            self.cartViewModel.cartKeys.remove(at: self.removedItemIndexNumber)
            self.cartView.cartTableView.reloadData()
            self.cartViewModel.updateCartProduct(productId: productId, count: count)
        } else {
            self.cartViewModel.updateCartProduct(productId: productId, count: count)
        }
    }
    
    func closeButtonTapped(productId: Int) {
        self.cartViewModel.cartProducts.remove(at: removedItemIndexNumber)
        self.cartViewModel.cartKeys.remove(at: removedItemIndexNumber)
        self.cartViewModel.updateCartProduct(productId: productId, count: 0)
        self.cartView.cartTableView.reloadData()
    }
    
}
extension CartViewController : CartViewModelProtocol {
    func didProductDeleteSuccessful() {
        
    }
    
    
    func didPlusOrMinusSuccessful() {
        self.totalPrice = 0.0
        self.cartView.cartTableView.reloadData()
    }
    
    func didError(_ error: String) {
        GeneralPopup.showPopup(vc: self, image: .error, title: "Error", subtitle: error, buttonText: "Ok")
    }
    
    
    func didFetchCartList() {
        if cartViewModel.cartKeys.isEmpty {
            self.cartView.cartTableView.reloadData()
            self.cartView.emptyCart()
        } else {
            self.totalPrice = 0.0
            self.cartView.fullCart()
            self.cartView.cartTableView.reloadData()
        }
        
    }
}

extension CartViewController  {
    func totalPrice(price : Double, count : Int) {
        self.totalPrice += price*Double(count)
        self.cartView.priceLabel.text = "$\(totalPrice.rounded(digits: 1))"
    }
    //MARK: UI Action
    @objc func updateCartTable(_ notification: NSNotification) {
        guard let countProduct = notification.userInfo?["productCount"] as? Int else {return}
        guard let idProduct = notification.userInfo?["productId"] as? Int else {return}
        cartViewModel.updateCartProduct(productId: idProduct, count: countProduct)
    }
}


// MARK: - UITableView Methods
extension CartViewController : UITableViewDelegate, UITableViewDataSource {
    func setupTableDelegates() {
        cartView.cartTableView.delegate = self
        cartView.cartTableView.dataSource = self
        cartView.cartTableView.rowHeight = 170
        cartView.cartTableView.separatorStyle = .none
        cartView.cartTableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartViewModel.cartProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.cartView.cartTableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        cell.viewController = self
        cell.delegate = self
        
        for (key,value) in cartViewModel.cartKeyAndValue {
            if key == "\(cartViewModel.cartProducts[indexPath.row].id!)" {
                self.count = value
                break
            }
        }
        
        cell.configure(data: cartViewModel.cartProducts[indexPath.row], count:self.count ?? 1)
        self.totalPrice(price: cartViewModel.cartProducts[indexPath.row].price ?? 0, count: self.count ?? 0)
        cell.callback = { currentCell in
            self.removedItemIndexNumber = tableView.indexPath(for: currentCell)!.item
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for (key,value) in cartViewModel.cartKeyAndValue {
            if key == "\(cartViewModel.cartProducts[indexPath.row].id!)" {
                self.count = value
                break
            }
        }
        let productDetailVC = ProductDetailViewController()
        productDetailVC.modalPresentationStyle = .overFullScreen
        productDetailVC.product = cartViewModel.cartProducts[indexPath.row]
        productDetailVC.productDetailView.updateCountLabel(count: self.count ?? 0)
        productDetailVC.productDetailView.count = self.count ?? 0
        present(productDetailVC, animated: true)
    }
}

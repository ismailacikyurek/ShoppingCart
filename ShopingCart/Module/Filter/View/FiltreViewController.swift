//
//  FiltreViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 14.03.2023.
//

import UIKit

class FiltreViewController: UIViewController {
    
    let filterView = FilterView()
    let filterViewModel = FilterViewModel()
    var categoryUserInfo = ["selectedCategory" : SelectedCategory.jewelery]
    var category = SelectedCategory.jewelery
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = filterView
        filterView.interface = self
        filterViewModel.delegate = self
        filterViewModel.allFetchProducts()
        setTableView()
    }
}

extension FiltreViewController : FilterViewInterfaceProtocol {
    func dissmisButtonTapped() {
        dismiss(animated: true)
    }
}


extension FiltreViewController  : FilterViewModelProtocol{
    func didError(_ error: String) {
        GeneralPopup.showPopup(vc: self, image: .error, title: "Error", subtitle: error, buttonText: "Ok")
    }
    
    func didProductsSuccessful() {
        self.filterView.categoryTableView.reloadData()
    }
    
}
extension FiltreViewController {
    func selectedCategory(category : SelectedCategory) {
        var categoryUserInfo = ["selectedCategory" : category]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "category_filter"),
                                        object: nil,
                                        userInfo: categoryUserInfo)
        dismiss(animated: true)
    }
}


// MARK: - UITableView Methods
extension FiltreViewController : UITableViewDelegate,UITableViewDataSource {
    func setTableView() {
        filterView.categoryTableView.register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.identifier)
        filterView.categoryTableView.delegate = self
        filterView.categoryTableView.dataSource = self
        filterView.categoryTableView.rowHeight = 30
        filterView.categoryTableView.separatorStyle = .singleLine
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterViewModel.categoryModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier, for: indexPath) as! FilterTableViewCell
        cell.configure(data: (self.filterViewModel.categoryModel[indexPath.row]))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0 : self.selectedCategory(category: .allCategory)
        case 1 : self.selectedCategory(category: .jewelery)
        case 2 : self.selectedCategory(category: .menSClothing)
        case 3 : self.selectedCategory(category: .womenSClothing)
        case 4 : self.selectedCategory(category: .electronics)
        default: print("")
        }
        
    }
}

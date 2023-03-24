//
//  FilterViewModel.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 14.03.2023.

import UIKit

//MARK: Protocols
protocol FilterViewModelProtocol: AnyObject {
    func didError(_ error: String)
    func didProductsSuccessful()
}

final class FilterViewModel {
    
    var categoryModel : [CategoryModel] = []
    weak var delegate: FilterViewModelProtocol?
    private let service : WebService = WebService()
    
    var jeweleryCount = 0
    var mensClothingCount  = 0
    var womensClothingCount  = 0
    var electorinsCount  = 0
    
    func allFetchProducts() {
        service.allProducts() { [self] response in
            guard let response = response else {return}
            for i in response {
                switch i.category?.rawValue {
                case Category.jewelery.rawValue :
                    self.jeweleryCount += 1
                case Category.menSClothing.rawValue :
                    self.mensClothingCount  += 1
                case Category.womenSClothing.rawValue :
                    self.womensClothingCount  += 1
                case Category.electronics.rawValue :
                    self.electorinsCount  += 1
                case .none: print("")
                case .some(_):print("")
                }
            }
            
            self.categoryModel =  [CategoryModel(categoryName: "All",categoryCount: response.count),
                                   CategoryModel(categoryName: "Jewelery", categoryCount: jeweleryCount),
                                   CategoryModel(categoryName: "Men's Clothing", categoryCount: mensClothingCount),
                                   CategoryModel(categoryName: "Women's Clothing", categoryCount: womensClothingCount),
                                   CategoryModel(categoryName: "Electroins", categoryCount: electorinsCount)
            ]
            self.delegate?.didProductsSuccessful()
        } onFail: { error in
            self.delegate?.didError(error?.localizedDescription ?? "error")
        }
    }
    
}

//
//  EndPoint.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 1.05.2023.
//

import Foundation

struct Constants {
    //MARK: API Constants
    static let BaseUrl = "https://fakestoreapi.com/"
}

enum Endpoint {
    case products
    case productsId(id: Int)
    case category
    case fetchCity
}

extension Endpoint {
    var url: URL {
        switch self {
        case .products:
            return URL(string: "\(Constants.BaseUrl)products")!
        case .productsId(let id):
            return URL(string: "\(Constants.BaseUrl)products/\(id)")!
        case .category:
            return URL(string: "\(Constants.BaseUrl)products/category/")!
        case .fetchCity:
            return URL(string: "https://raw.githubusercontent.com/merttoptas/JSON-il-ilce-kullanimi/master/app/src/main/res/raw/citys.json")!
        
        }
    }
}


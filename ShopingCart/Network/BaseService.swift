//
//  BaseService.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 12.03.2023.
//

import Foundation
import UIKit
import Alamofire


//MARK: Protocols
protocol ShoppingCartServiceProtokol {
    func fethAllPosts<T:Codable>(url:URL,onSuccess: @escaping (T) -> Void, onFail: @escaping (Error?) -> Void)
}

public struct ShopingCartDataService: ShoppingCartServiceProtokol {
    func fethAllPosts<T>(url: URL, onSuccess: @escaping (T) -> Void, onFail: @escaping (Error?) -> Void) where T : Decodable, T : Encodable {
        AF.request(url, method: .get).validate().responseDecodable(of:T.self) { (response) in
            guard let items =  response.value else {
                onFail(response.error)
                return
            }
            onSuccess(items)
        }
    }
    
}


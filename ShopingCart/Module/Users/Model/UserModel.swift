//
//  UserModel.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 8.03.2023.
//

import UIKit

struct User: Codable {
    var id: String?
    var username: String?
    var email: String?
    var addressList : [String: String]?
    var cart: [String : Int]?
    var favList: [String: Bool]?
    var recentlyList: [String: Bool]?
}

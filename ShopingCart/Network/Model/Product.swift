//
//  Product.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 12.03.2023.

import Foundation

// MARK: - Product
public struct Product: Codable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: Category?
    let image: String?
    let rating: Rating?
}

 enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}
// MARK: - Rating
struct Rating: Codable {
    let rate: Double?
    let count: Int?
}


// MARK: - CityModel
public struct CityModel: Codable {
    let cityDetail: [CityDetail]?
}

// MARK: - CityDetail
struct CityDetail: Codable {
    let id, name : String?
 
}

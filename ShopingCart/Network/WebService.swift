

import Alamofire
import UIKit



public class WebService:NSObject{
    let service: ShoppingCartServiceProtokol = ShopingCartDataService()
    
    public func allProducts(success: @escaping ([Product]?) -> Void,onFail: @escaping (Error?) -> Void){
        service.fethAllPosts(url: Endpoint.products.url ) { (b: [Product]) in
            success(b)
        } onFail: { error in
            onFail(error)
        }
    }
    
    public func productsId(id : Int,success: @escaping (Product?) -> Void,onFail: @escaping (Error?) -> Void) {
        service.fethAllPosts(url: Endpoint.productsId(id: id).url ) { (b: Product) in
            success(b)
        } onFail: { error in
            onFail(error)
        }
    }

    
    public func category(category : SelectedCategory,success: @escaping ([Product]?) -> Void,onFail: @escaping (Error?) -> Void) {
        service.fethAllPosts(url: URL(string: "\(Endpoint.category.url)\(category.rawValue)")! ) { (b: [Product]) in
            success(b)
        } onFail: { error in
            onFail(error)
        
        }
    }
    
    public func fetchCity(success: @escaping (CityModel?) -> Void,onFail: @escaping (Error?) -> Void) {
        service.fethAllPosts(url: Endpoint.fetchCity.url ) { (b: CityModel) in
            success(b)
        } onFail: { error in
            onFail(error)
        }
    }
    
    
}

public enum SelectedCategory: String {
    case allCategory = ""
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's%20clothing"
    case womenSClothing = "women's%20clothing"
}

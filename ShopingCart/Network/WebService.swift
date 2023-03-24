

import Alamofire
import UIKit


struct Constants {
    //MARK: API Constants
    static let BaseUrl = "https://fakestoreapi.com/"
}

public class WebService:NSObject{
    let service: ShoppingCartServiceProtokol = ShopingCartDataService()
    
    public func allProducts(success: @escaping ([Product]?) -> Void,onFail: @escaping (Error?) -> Void){
        service.fethAllPosts(url: Constants.BaseUrl + "products" ) { (b: [Product]) in
            success(b)
        } onFail: { error in
            onFail(error)
        }
    }
    
    public func productsId(id : Int,success: @escaping (Product?) -> Void,onFail: @escaping (Error?) -> Void) {
        service.fethAllPosts(url: Constants.BaseUrl + "products/\(id)" ) { (b: Product) in
            success(b)
        } onFail: { error in
            onFail(error)
        }
    }

    
    public func category(category : SelectedCategory,success: @escaping ([Product]?) -> Void,onFail: @escaping (Error?) -> Void) {
        service.fethAllPosts(url: Constants.BaseUrl + "products/category/\(category.rawValue)" ) { (b: [Product]) in
            success(b)
        } onFail: { error in
            onFail(error)
        }
    }
    
    public func fetchCity(success: @escaping (CityModel?) -> Void,onFail: @escaping (Error?) -> Void) {
        service.fethAllPosts(url: "https://raw.githubusercontent.com/merttoptas/JSON-il-ilce-kullanimi/master/app/src/main/res/raw/citys.json" ) { (b: CityModel) in
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


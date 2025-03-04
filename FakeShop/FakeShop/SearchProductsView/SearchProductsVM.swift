//
//  SearchProductsVM.swift
//  FakeShop
//
//  Created by 이태형 on 3/4/25.
//

import UIKit

class SearchProductsVM{
    var receivedProducts: [Product] = []
    let paginationCount = 8
    var showCount: Int = 0
    var showProducts: [Product] = []
    var sortType: SortType = .recent
    var searchText: String = ""
    
    func getProducts(category: String){
        ProductRequest.products(category: category){ res in
            switch res{
            case .success(let data):
                self.receivedProducts = data
//                NotificationCenter.default.post(name: Notification.Name("reloadPreviewItems"), object: nil, userInfo: ["pushData": data])
            case .failure(let err):
                print("Error: getCategories:", err.localizedDescription)
            }
        }
    }
    func sortProducts(){
        var temp: [Product] = self.receivedProducts
        if searchText.count > 0 {
            temp = receivedProducts.filter{ $0.title.contains(searchText) }
        }
    }
}

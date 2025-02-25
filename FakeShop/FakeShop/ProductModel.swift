//
//  ProductModel.swift
//  FakeShop
//
//  Created by 이태형 on 2/2/25.
//

import Foundation

struct Product: Codable{
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

struct Rating: Codable{
    let rate: Double
    let count: Int
}

enum Purchase{
    case buy
    case cart
    
    var str: String{
        switch self{
        case .buy: return "buy"
        case .cart: return "cart"
        }
    }
}

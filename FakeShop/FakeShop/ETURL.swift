//
//  ETURL.swift
//  FakeShop
//
//  Created by 이태형 on 2024/08/07.
//

import Foundation

extension URL{
    static let serviceTermsUrl = URL(string: "https://www.google.co.kr")!
    static let privateTermsUrl = URL(string: "https://www.naver.com")!
    static let signUpUrl = finalUrl("users")
    static let logInUrl = finalUrl("auth/login")
    static let categoriesUrl = finalUrl("products/categories")
    
    static func finalUrl(_ endPoint: String)-> URL{
        var urlStr: String = ""
    #if DEBUG
        urlStr = "https://fakestoreapi.com/"
    #elseif RELEASE
        urlStr = "https://fakestoreapi.com/"
    #endif
        return URL(string: "\(urlStr)\(endPoint)")!
    }
}

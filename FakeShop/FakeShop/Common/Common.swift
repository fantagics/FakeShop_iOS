//
//  Common.swift
//  FakeShop
//
//  Created by 이태형 on 1/16/25.
//

import UIKit

class Common{
    static let shared: Common = Common()
    private init(){}  //새로운 인스턴스 생성 방지

    var token: String = ""
    var loginType: LoginType = .none
    var categories: [String] = []
}

enum LoginType{
    case none
    case email
    case kakao
    case google
    case apple
}

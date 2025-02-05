//
//  Common.swift
//  FakeShop
//
//  Created by 이태형 on 1/16/25.
//

import UIKit

class Common{
    static let shared: Common = Common()
    private init(){}
    
    var token: String = ""
    var loginType: LoginType = .none
    var categories: [String] = []
}


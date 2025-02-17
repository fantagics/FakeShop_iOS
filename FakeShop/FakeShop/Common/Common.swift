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
    let noticeArr: [UIImage] = ["event_0", "event_1", "event_2"].map{UIImage(named: $0)}.compactMap{$0}
    var categories: [String] = []
}


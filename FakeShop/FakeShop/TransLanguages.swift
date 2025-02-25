//
//  TransLanguages.swift
//  FakeShop
//
//  Created by 이태형 on 2/2/25.
//

import UIKit

class Translation{  //-> json
    static let language: Translation = Translation()
    private init(){}
    
    var ko: [String:String] = [
        "":"",
        //category
        "all" : "전체",
        "electronics" : "디지털",
        "jewelery" : "브랜드 쥬얼리",
        "men's clothing" : "남성 의류",
        "women's clothing" : "여성 의류",
        //setting
        "orderHistory" : "주문내역",
        "cart" : "장바구니",
        "inquiryHistory" : "문의내역",
        "logout" : "로그아웃",
        //etc
        "more" : "더 보기",
        "buy" : "구매하기",
    ]
    
//    let type: [String:[String:String]] = [
//        "ko" : ko
//    ]
}

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
        "Category" : "카테고리",
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
        //sort
        "Newest Arrivals" : "신규 상품순",
        "Price: High To Low" : "높은 가격순",
        "Price: Low to High" : "낮은 가격순",
        "Avg. Customer Review" : "평점 높은순",
        "Best Sellers" : "판매 인기순",
        //etc
        "more" : "더 보기",
        "buy" : "구매하기",
        "error" : "오류",
        "Apply" : "적용하기",
        "Sort by" : "정렬기준",
    ]
    
//    let type: [String:[String:String]] = [
//        "ko" : ko
//    ]
}

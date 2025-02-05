//
//  TransLanguages.swift
//  FakeShop
//
//  Created by 이태형 on 2/2/25.
//

import UIKit

class Translation{
    static let language: Translation = Translation()
    private init(){}
    
    var ko: [String:String] = [
        //category
        "all" : "전체",
        "electronics" : "디지털",
        "jewelery" : "브랜드 쥬얼리",
        "men's clothing" : "남성 의류",
        "women's clothing" : "여성 의류",
        
    ]
}

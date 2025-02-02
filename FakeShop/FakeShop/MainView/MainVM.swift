//
//  MainVM.swift
//  FakeShop
//
//  Created by 이태형 on 2/2/25.
//

import UIKit

class MainVM{
    
    func getCategories()->Result<Void,String>{
        Common.shared.categories = ["all"]
        ProductRequest.categories(){ res in
            switch res{
            case .success(let data):
                Common.shared.categories += data
            case .failure(let err):
            }
        }
    }
}

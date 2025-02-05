//
//  MainVM.swift
//  FakeShop
//
//  Created by 이태형 on 2/2/25.
//

import UIKit

class MainVM{
    
    func getCategories(completion: @escaping (Result<Void,Error>) -> Void){
        Common.shared.categories = ["all"]
        ProductRequest.categories(){ res in
            switch res{
            case .success(let data):
                print(data)
                Common.shared.categories += data
                completion(.success(()))
            case .failure(let err):
                print("Error: getCategories:", err.localizedDescription)
                completion(.failure(err))
            }
        }
    }
    
    
}

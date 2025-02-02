//
//  LoginVM.swift
//  FakeShop
//
//  Created by 이태형 on 2024/08/07.
//

import UIKit

class LoginVM {
    var isAgreeTerms: Bool = false
    
    func loginValid(_ idTextField: UITextField, _ pwTextField: UITextField, completion: @escaping (Result<String,LoginError>) -> Void){
        guard isAgreeTerms else{
            completion(.failure(.rejectAgreement))
            return
        }
        guard let idText = idTextField.text, !idText.isEmpty else{
            completion(.failure(.idEmpty))
            return
        }
        guard let pwText = pwTextField.text, !pwText.isEmpty else{
            completion(.failure(.pwEmpty))
            return
        }
        guard NetworkMonitor.shared.isConnected else{
            completion(.failure(.unConected))
            return
        }
        AuthRequest.logIn(idText, pwText){ res in
            switch res{
            case .success(let data): //token
                Common.shared.token = data.token
                Common.shared.loginType = .email
                //UserDefaults
                completion(.success(data.token))
            case .failure(let err):
                completion(.failure(.fail))
            }
        }
    }
}


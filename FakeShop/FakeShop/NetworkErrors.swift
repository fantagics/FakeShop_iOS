//
//  NetworkErrors.swift
//  FakeShop
//
//  Created by 이태형 on 2/2/25.
//

import UIKit

enum LoginError: Error{
    case rejectAgreement
    case idEmpty
    case pwEmpty
    case unConected
    case fail
    
    var message: String{
        switch self{
        case .rejectAgreement: "서비스 이용약관 및 개인정보 이용약관에 동의해주세요"
        case .idEmpty: "id를 입력해주세요."
        case .pwEmpty: "비밀번호를 입력해주세요."
        case .unConected: "로그인에 실패했습니다. 네트워크 연결을 확인해주세요."
        case .fail: "로그인에 실패했습니다. 아이디와 비밀번호를 다시 한번 확인해주세요. 같은 현상이 계속되는 경우 문의 바랍니다." //분리필요
        }
    }
}

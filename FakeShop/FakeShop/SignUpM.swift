//
//  SignUpM.swift
//  FakeShop
//
//  Created by 이태형 on 12/26/24.
//

import Foundation

enum TextFieldType: Int, CaseIterable{
    case id
    case password
    case confirmPassword
    case firstName
    case lastName
    case email
    case address
    case phone
    case error
    
    var title: String{
        switch self{
            case .id: return "id"
            case .password : return "password"
            case .confirmPassword : return "confirm password"
            case .firstName : return "first name"
            case .lastName : return "last name"
            case .email : return "email"
            case .address : return "address"
            case .phone : return "phone"
            default: return "error"
        }
    }
    
    var placeholder: String{
        switch self{
            case .id: return "영문, 숫자 조합 8자 이상"
            case .password : return "영문, 숫자, 특수문자 포함 8자 이상"
            case .confirmPassword : return "한번 더 입력해주세요"
            case .firstName : return "이름"
            case .lastName : return "성"
            case .email : return "example@site.type"
            case .address : return "주소"
            case .phone : return "010-0000-0000"
            default: return "error"
        }
    }
    
    var validPattern: String{
        switch self{
            case .id: return "^[a-zA-Z0-9]{8,20}$"
            case .password: return "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-=;':,.<>?\"]).{8,20}$"
//            case .confirmPassword: return ""
//            case .firstName: return ""
//            case .lastName: return ""
            case .email: return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9]+\\.[a-z]{2,}$"
//            case .address: return ""
            case .phone: return "^01[0-1 7][-][0-9]{4}[-][0-9]{4}$"
            default: return "error"
        }
    }
    
    var guideMessage: String{
        switch self{
            case .id: return "영문 대소문자, 숫자 조합 8~20자로 입력해주세요"
            case .password : return "영문 대소문자, 숫자, 특수문자 포함 8자 이상"
            case .confirmPassword : return "위의 비밀번호와 일치하지 않습니다."
            case .firstName : return "올바른 이름형식이 아닙니다."
            case .lastName : return "올바른 성씨형식이 아닙니다."
            case .email : return "example@site.type"
            case .address : return "올바른 주소형식이 아닙니다."
            case .phone : return "01*-****-****"
            default: return "error"
        }
    }
}

enum SignUpError: Int, Error{
    case idError
    case pwError
    case confirmPwError
    case firstNameError
    case lastNameError
    case emailError
    case addressError
    case phoneError
    case anonymousError
    
    var validMessage: String{
        switch self{
            case .idError: return "잘못된 id 입력입니다. 영문 대소문자, 숫자 조합 8~20자로 입력해주세요."
            case .pwError : return "잘못된 password 입력입니다. 영문, 숫자, 특수문자 포함 8자 이상 입력해주세요."
            case .confirmPwError : return "비밀번호와 비밀번호 재확인란이 일치하지 않습니다."
            case .firstNameError : return "이름란이 비어었습니다. 한글자 이상 입력해주세요."
            case .lastNameError : return "성씨란이 비어었습니다. 한글자 이상 입력해주세요."
            case .emailError : return "올바른 email형식이 아닙니다."
            case .addressError : return "올바른 주소형식이 아닙니다."
            case .phoneError : return "올바른 핸드폰 번호 형식이 아닙니다."
            default: return "error"
        }
    }
}

//
//  SignUpVM.swift
//  FakeShop
//
//  Created by 이태형 on 12/26/24.
//

import UIKit

class SignUpVM{
    func guideMessageForValid(_ textField: UITextField, _ textType: TextFieldType, _ string: String?, _ pw: String = "") -> String{
        guard let text: String = textField.text else{ return TextFieldType.error.guideMessage }
        let str: String = composeString(text, string)
        return isValidTextField(str, textType, pw) ? " " : textType.guideMessage
    }
    
    func isValidTextField(_ text: String, _ textType: TextFieldType, _ pw: String = "") -> Bool {
        switch textType{
            case .id, .password, .email, .phone:
                return regexValid(text, textType)
            case .confirmPassword:
                return text == pw
            case .firstName, .lastName, .address:
                return !text.isEmpty
            default: return false
        }
    }
    
    func regexValid(_ text: String, _ textType: TextFieldType) -> Bool {
        let pattern: String = textType.validPattern
        return text.range(of: pattern, options: .regularExpression) != nil
    }
    
    func composeString(_ text: String, _ string: String?) -> String {
        var str: String = text
        if string != nil {
            if string == ""{
                str.removeLast()
            } else {
                str += string!
            }
        }
        return str
    }
    
    func isValidSignUp(_ textFields: [UITextField], _ fieldTypes: [TextFieldType], _ pw: String) -> Result<Bool, SignUpError>{
        guard textFields.count == fieldTypes.count else{return .failure(.anonymousError)}
        for idx in 0..<textFields.count{
            guard let text = textFields[idx].text else{return .failure(.anonymousError)}
            if fieldTypes[idx] == .confirmPassword {
                if !isValidTextField(text, fieldTypes[idx], pw){
                    return .failure(SignUpError(rawValue: idx) ?? .anonymousError)
                }
            } else{
                if !isValidTextField(text, fieldTypes[idx]){
                    return .failure(SignUpError(rawValue: idx) ?? .anonymousError)
                }
            }
        }
        return .success(true)
    }
    
}

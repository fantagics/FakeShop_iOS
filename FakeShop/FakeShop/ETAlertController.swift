//
//  ETAlertController.swift
//  FakeShop
//
//  Created by 이태형 on 1/15/25.
//

import UIKit

extension UIAlertController{
    static func messageAlert(title: String?, message: String?, completion: (()-> ())? )-> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default, handler: {_ in
            (completion ?? {})()
        })
        alertController.addAction(confirmAction)
        return alertController
    }
    
    static func cancelableMessageAlert(title: String?, message: String?, completion: (()-> ())? )-> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .destructive, handler: {_ in
            (completion ?? {})()
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        confirmAction.setValue(UIColor.blue.withAlphaComponent(0.7), forKey: "titleTextColor")
        cancelAction.setValue(UIColor.black.withAlphaComponent(0.6), forKey: "titleTextColor")
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        return alertController
    }
}

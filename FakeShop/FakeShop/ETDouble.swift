//
//  ETDouble.swift
//  FakeShop
//
//  Created by 이태형 on 2/15/25.
//

import UIKit

extension Double{
    func toCurrencyFormat()-> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumSignificantDigits = 2
        guard let price = formatter.string(for: self)else{
            return "Formatter Error"
        }
        return price
    }
}

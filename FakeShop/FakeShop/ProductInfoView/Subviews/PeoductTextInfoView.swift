//
//  PeoductTextInfoView.swift
//  FakeShop
//
//  Created by 이태형 on 2/20/25.
//

import UIKit

class PeoductTextInfoView: UIView {
    var starArray: [UIImageView] = []
    
    let category: UILabel = UILabel()
    let title: UILabel = UILabel()
    private let ratingStack: UIStackView = UIStackView()
    let ratingCount: UILabel = UILabel()
    let price: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Function
extension PeoductTextInfoView{
    
    
}

//MARK: - SETUP
extension PeoductTextInfoView{
    private func setup(){
        setAttribute()
        setUI()
    }
    
    private func setAttribute(){
        for i in 0..<5{
            ratingStack.addArrangedSubview(UIImageView())
            starArray.append(ratingStack.subviews[i] as? UIImageView ?? UIImageView())
        }
    }
    
    private func setUI(){
        
        NSLayoutConstraint.activate([
            
        ])
    }
}

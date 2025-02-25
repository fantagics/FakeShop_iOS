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
    func setRatingStar(rate: Double){
        let v = Int(round(rate * 2))
        for idx in 0..<5{
            starArray[idx].tintColor = .primary
            if v / ((idx + 1) * 2) > 0{
                starArray[idx].image = UIImage(systemName: "star.fill")
            } else if v % (idx * 2) > 0{
                starArray[idx].image = UIImage(systemName: "star.leadinghalf.filled")
            } else{
                starArray[idx].image = UIImage(systemName: "star")
            }
        }
    }
    
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
        
        [category].forEach{
            $0.textColor = .gray
            $0.font = .NanumGothic(type: .Regular, size: 12)
        }
        [title].forEach{
            $0.font = .NanumGothic(type: .Bold, size: 20)
            $0.numberOfLines = 2
        }
        [ratingStack].forEach{
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fill
            $0.spacing = 6
        }
        [ratingCount].forEach{
            $0.textColor = .gray
            $0.font = .NanumGothic(type: .Regular, size: 12)
        }
        [price].forEach{
            $0.font = .NanumGothic(type: .Regular, size: 18)
        }
    }
    
    private func setUI(){
        [category, title, ratingStack, ratingCount, price].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            category.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            category.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            category.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -8),
            
            title.topAnchor.constraint(equalTo: category.bottomAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: category.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            ratingStack.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            ratingStack.leadingAnchor.constraint(equalTo: category.leadingAnchor),
            ratingStack.heightAnchor.constraint(equalToConstant: 20),
            
            ratingCount.centerYAnchor.constraint(equalTo: ratingStack.centerYAnchor),
            ratingCount.leadingAnchor.constraint(equalTo: ratingStack.trailingAnchor, constant: 8),
            ratingCount.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -16),
            
            price.topAnchor.constraint(equalTo: ratingStack.bottomAnchor, constant: 8),
            price.leadingAnchor.constraint(equalTo: category.leadingAnchor),
            price.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
}

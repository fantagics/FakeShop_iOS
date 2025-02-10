//
//  RecommendItemCell.swift
//  FakeShop
//
//  Created by 이태형 on 2/10/25.
//

import UIKit

class RecommendItemCell: UICollectionViewCell {
    static let identifier: String = String(describing: RecommendItemCell.self)
    
    private let imageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let priceLabel: UILabel = UILabel()
    private let ratingLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Function
extension RecommendItemCell{
    
}

//MARK: - SETUP
extension RecommendItemCell{
    private func setup(){
        setAttribute()
        setUI()
    }
    
    private func setAttribute(){
        [imageView].forEach{
            $0.image = UIImage(named: "apple_logo")
            $0.contentMode = .scaleAspectFit
        }
        [titleLabel].forEach{
            $0.text = "제품명"
        }
        [priceLabel].forEach{
            $0.text = "$199.9"
        }
        [ratingLabel].forEach{
            $0.text = "⭐️ 4.6 / 🛒 400"
        }
    }
    
    private func setUI(){
        let labelStack: UIStackView = UIStackView(arrangedSubviews: [titleLabel, priceLabel, ratingLabel])
        [labelStack].forEach{
            $0.axis = .vertical
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.spacing = 8
        }
        [imageView, labelStack].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            labelStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            labelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            labelStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            labelStack.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10),
        ])
    }
}

//
//  BannerCollectionViewCell.swift
//  FakeShop
//
//  Created by 이태형 on 2/11/25.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell{
    static let identifier: String = String(describing: BannerCollectionViewCell.self)
    
    let imageView: UIImageView = UIImageView() //-> FSPagerView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [imageView].forEach{
            $0.backgroundColor = .gray
            $0.contentMode = .scaleAspectFit
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview("MainVC"){
    return UINavigationController(rootViewController: MainVC())
    
}

//
//  PurchaseBottomSheetVC.swift
//  FakeShop
//
//  Created by 이태형 on 2/25/25.
//

import UIKit

class PurchaseBottomSheetVC: UIViewController {
    
    var product: Product?
    var viewType: Purchase = .cart
    var bottomSheetTopAnchor: NSLayoutConstraint = NSLayoutConstraint()
    let backgroundView: UIView = UIView()
    private let bottomSheet: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let priceLabel: UILabel = UILabel()
    private let countView: UIView = UIView()
    private let countLabelView: UIView = UIView()
    private let countLabel: UILabel = UILabel()
    private let countPlusButton: UIButton = UIButton()
    private let countMinusButton: UIButton = UIButton()
    private let submitButton: UIButton = UIButton()
    
    //MARK: LC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
}

//#Preview("PurchaseBottomSheetVC"){
//    return PurchaseBottomSheetVC()
//}
#Preview("ProductInfoVC"){
    let vc = ProductInfoVC()
    vc.product = Common.shared.dummyProduct
    return UINavigationController(rootViewController: vc)
}

//MARK: - func
extension PurchaseBottomSheetVC{
    @objc private func didTapGesture(_ sender: UIGestureRecognizer){
        self.dismiss(animated: false)
    }
}

//MARK: - setUI
extension PurchaseBottomSheetVC{
    private func setup(){
        setAttribute()
        setUI()
    }
    //Attribute
    private func setAttribute(){
//        view.backgroundColor = .black.withAlphaComponent(0.1)
        bottomSheetTopAnchor = bottomSheet.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -250)
        
        [backgroundView].forEach{
            $0.backgroundColor = .black.withAlphaComponent(0.1)
            let dissmissGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGesture(_:)))
            $0.addGestureRecognizer(dissmissGesture)
        }
        
        let item = product ?? Common.shared.dummyProduct
        
        [bottomSheet].forEach{
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 32
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        [titleLabel].forEach{
            $0.text = item.title
            $0.numberOfLines = 1
            $0.font = .NanumGothic(type: .Bold, size: 24)
        }
        [priceLabel].forEach{
            $0.text = item.price.toCurrencyFormat()
            $0.textColor = .primary
            $0.font = .NanumGothic(type: .Bold, size: 24)
        }
        [countView].forEach{
            $0.backgroundColor = .primary
            $0.layer.cornerRadius = 25
        }
        [countLabelView].forEach{
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 10
        }
        [countLabel].forEach{
            $0.font = .NanumGothic(type: .Bold, size: 24)
            $0.textColor = .primary
            $0.textAlignment = .center
            $0.text = "0"
        }
        countMinusButton.setImage(UIImage(systemName: "minus"), for: .normal)
        countPlusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        [countMinusButton, countPlusButton].forEach{
            $0.tintColor = .white
        }
        [submitButton].forEach{
            $0.backgroundColor = .primary
            $0.layer.cornerRadius = 16
            $0.titleLabel?.font = .NanumGothic(type: .Bold, size: 24)
            $0.setTitle(Translation.language.ko[viewType.str], for: .normal)
        }
    }
    //UI
    private func setUI(){
        [backgroundView, bottomSheet].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        [titleLabel, priceLabel, countView, submitButton].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            bottomSheet.addSubview($0)
        }
        [countMinusButton, countPlusButton, countLabelView].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            countView.addSubview($0)
        }
        [countLabel].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            countLabelView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            bottomSheetTopAnchor,
            bottomSheet.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheet.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomSheet.topAnchor, constant: 32),
            
            titleLabel.topAnchor.constraint(equalTo: bottomSheet.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: bottomSheet.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: bottomSheet.trailingAnchor, constant: -24),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            countView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
            countView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            countView.widthAnchor.constraint(equalToConstant: 160),
            countView.heightAnchor.constraint(equalToConstant: 50),
            
            countLabelView.centerXAnchor.constraint(equalTo: countView.centerXAnchor),
            countLabelView.centerYAnchor.constraint(equalTo: countView.centerYAnchor),
            countLabelView.widthAnchor.constraint(equalToConstant: 60),
            countLabelView.heightAnchor.constraint(equalToConstant: 40),
            
            countLabel.topAnchor.constraint(equalTo: countLabelView.topAnchor),
            countLabel.bottomAnchor.constraint(equalTo: countLabelView.bottomAnchor),
            countLabel.leadingAnchor.constraint(equalTo: countLabelView.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: countLabelView.trailingAnchor),
            
            countPlusButton.topAnchor.constraint(equalTo: countView.topAnchor),
            countPlusButton.bottomAnchor.constraint(equalTo: countView.bottomAnchor),
            countPlusButton.leadingAnchor.constraint(equalTo: countLabelView.trailingAnchor),
            countPlusButton.trailingAnchor.constraint(equalTo: countView.trailingAnchor),
            
            countMinusButton.topAnchor.constraint(equalTo: countView.topAnchor),
            countMinusButton.bottomAnchor.constraint(equalTo: countView.bottomAnchor),
            countMinusButton.leadingAnchor.constraint(equalTo: countView.leadingAnchor),
            countMinusButton.trailingAnchor.constraint(equalTo: countLabelView.leadingAnchor),
            
            submitButton.topAnchor.constraint(equalTo: countView.bottomAnchor, constant: 24),
            submitButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            
            bottomSheet.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
}

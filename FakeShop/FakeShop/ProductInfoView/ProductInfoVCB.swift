//
//  ProductInfoVCB.swift
//  FakeShop
//
//  Created by 이태형 on 2/21/25.
//

import UIKit

class ProductInfoVCB: UIViewController {
    
    private let scrollView: UIScrollView = UIScrollView()
    private let contents: UIView = UIView()
    private let imageView: UIImageView = UIImageView()
    private let productInfomation: PeoductTextInfoView = PeoductTextInfoView()
    private let underLine: UIView = UIView()
    private let bottomBar: UIView = UIView()
    private let peoductDescription: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewConfig()
    }
    
}

#Preview("ProductInfoVCB"){
    return UINavigationController(rootViewController: ProductInfoVCB())
}

//MARK: - Function
extension ProductInfoVCB{
    
}

//MARK: - SETUP
extension ProductInfoVCB{
    private func setViewConfig(){
        setNavigation()
        setAttribute()
        setUI()
    }
    
    private func setNavigation(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .foregroundColor : UIColor.white,
            .font : UIFont.boldSystemFont(ofSize: 22)
        ]
        appearance.backgroundColor = .primary
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setAttribute(){
        view.backgroundColor = .white
        
        [bottomBar].forEach{
            $0.backgroundColor = .primary
        }
        
        [imageView].forEach{
            $0.backgroundColor = .white
        }
        
        [productInfomation].forEach{
            $0.category.text = "디지털"
            $0.title.text = "Product Name Product Name Product Name Product Name Product Name"
            $0.setRatingStar(rate: 2.8)
            $0.ratingCount.text = "(203)"
            $0.price.text = "$ 64.0"
        }
        
        underLine.backgroundColor = .black
        
        [peoductDescription].forEach{
            $0.textColor = .darkGray
            $0.numberOfLines = 0
            $0.font = .NanumGothic(type: .Regular, size: 30)
            $0.text = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
        }
    }
    
    private func setUI(){
        contents.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contents)
        
        [scrollView, bottomBar].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [imageView, productInfomation, underLine, peoductDescription].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contents.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 100),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomBar.topAnchor),
            
            contents.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contents.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contents.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contents.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contents.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contents.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contents.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contents.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5625),
            
            productInfomation.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            productInfomation.leadingAnchor.constraint(equalTo: contents.leadingAnchor),
            productInfomation.trailingAnchor.constraint(equalTo: contents.trailingAnchor),
            
            underLine.topAnchor.constraint(equalTo: productInfomation.bottomAnchor),
            underLine.leadingAnchor.constraint(equalTo: contents.leadingAnchor),
            underLine.trailingAnchor.constraint(equalTo: contents.trailingAnchor),
            underLine.heightAnchor.constraint(equalToConstant: 2),
            
            peoductDescription.topAnchor.constraint(equalTo: underLine.bottomAnchor, constant: 16),
            peoductDescription.leadingAnchor.constraint(equalTo: contents.leadingAnchor, constant: 16),
            peoductDescription.trailingAnchor.constraint(equalTo: contents.trailingAnchor, constant: -16),
            underLine.bottomAnchor.constraint(equalTo: contents.bottomAnchor, constant: -16),
        ])
    }
}

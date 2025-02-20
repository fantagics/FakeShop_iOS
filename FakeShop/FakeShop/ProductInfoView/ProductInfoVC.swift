//
//  ProductInfoVC.swift
//  FakeShop
//
//  Created by 이태형 on 2/20/25.
//

import UIKit

class ProductInfoVC: UIViewController {
    
    private let scrollView: UIScrollView = UIScrollView()
    private let contents: UIView = UIView()
    private let imageView: UIImageView = UIImageView()
    private let bottomBar: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewConfig()
    }
    
}

#Preview("ProductInfoVC"){
    return UINavigationController(rootViewController: ProductInfoVC())
}

//MARK: - Function
extension ProductInfoVC{
    
}

//MARK: - SETUP
extension ProductInfoVC{
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
        [bottomBar].forEach{
            $0.backgroundColor = .primary
        }
    }
    
    private func setUI(){
        contents.backgroundColor = .orange
        contents.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contents)
        
        [scrollView, bottomBar].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
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
            contents.heightAnchor.constraint(equalToConstant: 1000),
        ])
    }
}

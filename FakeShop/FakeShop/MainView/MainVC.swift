//
//  MainVC.swift
//  FakeShop
//
//  Created by 이태형 on 2024/07/27.
//

import UIKit

class MainVC: UIViewController {
    
    //MARK: LC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
}

#Preview("MainVC"){
    return UINavigationController(rootViewController: MainVC())
    
}

//MARK: - Func
extension MainVC{
    
}

//MARK: - inital_UI
extension MainVC{
    private func setup(){
        setNavigation()
        setAttribute()
        setUI()
    }
    //Navigation
    private func setNavigation(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primary
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let logoImageView: UIImageView = UIImageView()
        logoImageView.image = UIImage(named: "appBarLogo")
        logoImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = logoImageView
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 647 / 224).isActive = true
        
        let cartButton: UIBarButtonItem = UIBarButtonItem()
        cartButton.image = UIImage(systemName: "cart")
        self.navigationItem.rightBarButtonItem = cartButton
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    //Attribute
    private func setAttribute(){
        self.view.backgroundColor = .white
    }
    //UI
    private func setUI(){
        
        NSLayoutConstraint.activate([
            
        ])
    }
}

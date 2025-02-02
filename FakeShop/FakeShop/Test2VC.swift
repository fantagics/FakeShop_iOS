//
//  Test2VC.swift
//  FakeShop
//
//  Created by 이태형 on 2024/12/02.
//

import UIKit

class Test2VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewConfig()
    }
    
}

#Preview("Test2VC"){
    return Test2VC()
}

//MARK: - Function
extension Test2VC{
    
}

//MARK: - SETUP
extension Test2VC{
    private func setViewConfig(){
        setAttribute()
        setUI()
    }
    
    private func setAttribute(){
        self.view.backgroundColor = .cyan
    }
    
    private func setUI(){
        
        NSLayoutConstraint.activate([
            
        ])
    }
}

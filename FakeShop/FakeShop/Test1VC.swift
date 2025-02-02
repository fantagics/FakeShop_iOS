//
//  Test1VC.swift
//  FakeShop
//
//  Created by 이태형 on 2024/12/02.
//

import UIKit

class Test1VC: UIViewController {
    
    private let btn1: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewConfig()
    }
    
}

#Preview("Test1VC"){
    return Test1VC()
}

//MARK: - Function
extension Test1VC{
    @objc func didTapButton(_ sender: UIButton){
        let nextvc = Test2VC()
        self.navigationController?.pushViewController(nextvc, animated: true)
    }
}

//MARK: - SETUP
extension Test1VC{
    private func setViewConfig(){
        setAttribute()
        setUI()
    }
    
    private func setAttribute(){
        self.navigationItem.title = "AAAA"
        view.backgroundColor = UIColor.brown
        
        [btn1].forEach{
            $0.setTitle("Next", for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
            $0.setTitleColor(.blue, for: .normal)
            $0.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        }
    }
    
    private func setUI(){
        [btn1].forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            btn1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

//
//  SideMenuView.swift
//  FakeShop
//
//  Created by 이태형 on 1/31/25.
//

import UIKit

class SideMenuView: UIView{
    
    private let titleLabel: UILabel = UILabel()
    private let categoryTable: UITableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#Preview("MainTabBarController"){
    return MainTabBarController()
}

//MARK: - Func
extension SideMenuView{
    
}

//MARK: - inital_UI
extension SideMenuView{
    private func setup(){
        setAttribute()
        setUI()
    }
    //Attribute
    private func setAttribute(){
        self.backgroundColor = .primary
        
        [titleLabel].forEach{
            $0.text = "카테고리"
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 20, weight: .bold)
        }
        
        [categoryTable].forEach{
            $0.dataSource = self
            $0.delegate = self
        }
    }
    //UI
    private func setUI(){
        [titleLabel,].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -100)
        ])
    }
}


//MARK: - DataSource & Delegate
extension SideMenuView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
extension SideMenuView: UITableViewDelegate{
    
}


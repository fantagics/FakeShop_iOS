//
//  SearchProductsVC.swift
//  FakeShop
//
//  Created by 이태형 on 2/28/25.
//

import UIKit
import Kingfisher

class SearchProductsVC: UIViewController {
    var category: String = "all"
    
    private let titleView: CategoryTitleView = CategoryTitleView()
    private let searchBar: SearchTopBar = SearchTopBar()
    private let productCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout{ (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            
            //Group (row)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(3/4))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            //Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            
            return section
        }
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    //MARK: LC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewConfig()
    }
    
}

#Preview("SearchProductsVC"){
    return UINavigationController(rootViewController: SearchProductsVC())
}

//MARK: - Function
extension SearchProductsVC{
    @objc private func didTapCartButton(_ sender: UIBarButtonItem){
        print("CART")
    }
}

//MARK: - SETUP
extension SearchProductsVC{
    private func setViewConfig(){
        setNavigation()
        setAttribute()
        setUI()
    }
    
    private func setNavigation(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primary
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationItem.titleView = titleView
        titleView.translatesAutoresizingMaskIntoConstraints = false
        if let h = self.navigationController?.navigationBar.frame.size.height{
            titleView.heightAnchor.constraint(equalToConstant: h - 2).isActive = true
        }
        
        let cartButton: UIBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "cart"),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(didTapCartButton(_:))
        )
        self.navigationItem.rightBarButtonItem = cartButton
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    private func setAttribute(){
        titleView.setTitle(category: category)
        
        [productCollectionView].forEach{
            $0.register(ProductCollectionCell.self, forCellWithReuseIdentifier: ProductCollectionCell.identifier)
            $0.dataSource = self
            $0.delegate = self
        }
    }
    
    private func setUI(){
        [searchBar, productCollectionView].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 68),
            
            productCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            productCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}


//MARK: - Datasource & Delegate
extension SearchProductsVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ProductCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.identifier, for: indexPath) as? ProductCollectionCell else{return UICollectionViewCell()}
        [Common.shared.dummyProduct].forEach{
            cell.preview.kf.setImage(with: URL(string: $0.image))
            cell.titleLabel.text = $0.title
            cell.ratingLabel.text = "⭐️ \($0.rating.rate) / 🛒 \($0.rating.count)"
            cell.priceLabel.text = $0.price.toCurrencyFormat()
        }
        return cell
    }
}
extension SearchProductsVC: UICollectionViewDelegate{
}

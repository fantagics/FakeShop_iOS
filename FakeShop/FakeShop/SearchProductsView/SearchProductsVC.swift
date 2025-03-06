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
    private let vm: SearchProductsVM = SearchProductsVM()
    
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
    let categoryPicker: UIPickerView = UIPickerView()
    let sortTypePicker: UIPickerView = UIPickerView()
    
    //MARK: LC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewConfig()
        initProducts()
    }
    
}

#Preview("SearchProductsVC"){
    return UINavigationController(rootViewController: SearchProductsVC())
}

//MARK: - Function
extension SearchProductsVC{
    private func initProducts(){
        vm.getProducts(category: self.category)
        vm.sortProducts()
        productCollectionView.reloadData()
    }
    
    @objc private func didTapCartButton(_ sender: UIBarButtonItem){
        print("CART")
        print(Common.shared.categories)
        print("REC: \(vm.receivedProducts.count)")
        print("FIT: \(vm.filteredProducts.count)")
        print("SOR: \(vm.sortedProducts.count)")
        productCollectionView.reloadData()
    }
    
    @objc private func didTapBackButton(_ sender: UIBarButtonItem){
        self.dismiss(animated: false)
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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(didTapBackButton(_:)))
        
        let cartButton: UIBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "cart"),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(didTapCartButton(_:))
        )
        self.navigationItem.rightBarButtonItem = cartButton
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.backButtonDisplayMode = .minimal
    }
    
    private func setAttribute(){
        [titleView].forEach{
            $0.setTitle(category: category)
            $0.delegate = self
        }
        
        searchBar.delegate = self
        
        [productCollectionView].forEach{
            $0.register(ProductCollectionCell.self, forCellWithReuseIdentifier: ProductCollectionCell.identifier)
            $0.dataSource = self
            $0.delegate = self
        }
        
        [categoryPicker, sortTypePicker].forEach{
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
        return vm.sortedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ProductCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.identifier, for: indexPath) as? ProductCollectionCell else{return UICollectionViewCell()}
        [vm.sortedProducts[indexPath.item]].forEach{
            cell.preview.kf.setImage(with: URL(string: $0.image))
            cell.titleLabel.text = $0.title
            cell.ratingLabel.text = "⭐️ \($0.rating.rate) / 🛒 \($0.rating.count)"
            cell.priceLabel.text = $0.price.toCurrencyFormat()
        }
        return cell
    }
}
extension SearchProductsVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextvc: ProductInfoVC = ProductInfoVC()
        nextvc.product = vm.sortedProducts[indexPath.item]
        self.navigationController?.pushViewController(nextvc, animated: true)
    }
}

extension SearchProductsVC: CategoryTitleViewDelegate{
    func didTapTitle() {
        guard let prevIdx: Int = Common.shared.categories.firstIndex(of: self.category) else{return}
        let alert: UIAlertController = UIAlertController.pickerViewActionSheet(prev: prevIdx, title: Translation.language.ko["Category"], picker: categoryPicker, completion: {
            let selected: Int = self.categoryPicker.selectedRow(inComponent: 0)
            self.category = Common.shared.categories[selected]
            self.titleView.setTitle(category: self.category)
            self.vm.getProducts(category: self.category)
            self.vm.sortProducts()
            self.productCollectionView.reloadData()
        })
        self.present(alert, animated: true)
    }
}

extension SearchProductsVC: SearchTopBarDelegate{
    func didTapSearchButton(searchText: String) {
        self.vm.searchText = searchText
        self.vm.sortProducts()
        self.productCollectionView.reloadData()
    }
    
    func didTapSortButton() {
        let prevIdx: Int = self.vm.sortType.rawValue
        let alert: UIAlertController = UIAlertController.pickerViewActionSheet(prev: prevIdx, title: Translation.language.ko["Sort by"], picker: sortTypePicker, completion: {
            self.vm.sortType = SortType(rawValue: self.sortTypePicker.selectedRow(inComponent: 0)) ?? .recent
            self.vm.sortProducts()
            self.productCollectionView.reloadData()
        })
        self.present(alert, animated: true)
    }
}

//PickerViewForActionSheet.swift

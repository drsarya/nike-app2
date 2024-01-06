//
//  ProductCollectionViewController.swift
//  nike-app2
//
//  Created by darya on 29.12.2023.
//  Copyright © 2023 darya. All rights reserved.
//
import SwiftUI
import UIKit

private let reuseIdentifier = "Cell"

class ProductViewController: UIViewController {
    
    var productId: Int?
    private var productName: String?
    private var selectedProduct: ProductInfo?
    private var items: [ProductInfo] = []
    private var apiService = ApiService()
    
    struct Product : Decodable {
        var id: Int
        var title: String
        var productInfos: [ProductInfo]
    }
    
    struct ProductInfo : Decodable {
        let mainImageName: String
        let nestedImagesNames: [String]
    }
    
    lazy var allProductImagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var productTypesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer( target: self, action: #selector(didSelectProductType(_:) ))
        collectionView.addGestureRecognizer(tap)
        
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    @objc func didSelectProductType(_ sender: UITapGestureRecognizer){
        let point = sender.location(in: productTypesCollectionView)
        if let indexPath = productTypesCollectionView.indexPathForItem(at: point){
            self.selectedProduct = items[indexPath.row]
            allProductImagesCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allProductImagesCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        productTypesCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        
        if(productId != nil){
            apiService.getProductById(id: productId!, completition: {(result) in
                switch result {
                case .success(let product):
                    self.productName = product.title
                    self.navigationItem.title = self.productName
                    self.items = product.productInfos
                    if(product.productInfos.count > 0){
                        self.selectedProduct = product.productInfos[0]
                    }
                    self.allProductImagesCollectionView.reloadData()
                    self.productTypesCollectionView.reloadData()
                case .failure(let error):
                    print("Error processing json data: \(error)")
                }
            })
        }
        
        setupView()
    }
    
    private func setupView(){
        view.backgroundColor = .white
        
        view.addSubview(allProductImagesCollectionView)
        view.addSubview(productTypesCollectionView)
        
        NSLayoutConstraint.activate([
            allProductImagesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            allProductImagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 0),
            allProductImagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            allProductImagesCollectionView.heightAnchor.constraint(equalToConstant: 550),
            
            productTypesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16),
            productTypesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 0),
            productTypesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            productTypesCollectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}

extension ProductViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.allProductImagesCollectionView){
            if(self.selectedProduct == nil){
                return 0
            }
            return self.selectedProduct!.nestedImagesNames.count
        }
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductCollectionViewCell else {
            fatalError("Could not dequeue cell")
        }
        
        if(collectionView == self.allProductImagesCollectionView){
            if(self.selectedProduct == nil){
                return cell
            }
            let item = self.selectedProduct!.nestedImagesNames[indexPath.row]
            cell.embded(in: self, imageUrl: item)
            return cell
        }
        
        let item = items[indexPath.row]
        cell.embded(in: self, imageUrl: item.mainImageName)
        return cell
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  sizeForItemAt indexPath: IndexPath) -> CGSize{
        if(collectionView == self.allProductImagesCollectionView){
            return CGSize(width: 392, height:460)
        }
        return CGSize(width: 170, height:170)
    }
}



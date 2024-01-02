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
    var productName: String = ""
    var selectedProduct: Item?
    var items: [Item] = []
    struct Item {
        var mainImageName: ProductContent
        var nestedImagesNames: [ProductContent]
        var title: String
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
        setupView()
    }
    
    private func setupView(){
        if(items.count > 0){
            self.selectedProduct = items[0]
        }
        view.backgroundColor = .white
        navigationItem.title = self.productName

        view.addSubview(allProductImagesCollectionView)
        view.addSubview(productTypesCollectionView)
        
        NSLayoutConstraint.activate([
            allProductImagesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            allProductImagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 16),
            allProductImagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            allProductImagesCollectionView.heightAnchor.constraint(equalToConstant: 550),
            
            productTypesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16),
            productTypesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 16),
            productTypesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productTypesCollectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}

extension ProductViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.allProductImagesCollectionView){
            return self.selectedProduct!.nestedImagesNames.count
        }
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductCollectionViewCell else {
            fatalError("Could not dequeue cell")
        }
        
        if(collectionView == self.allProductImagesCollectionView){
            let item = self.selectedProduct!.nestedImagesNames[indexPath.row]
            cell.embded(in: self, withContent: item)
            return cell
        }
        
        let item = items[indexPath.row]
        cell.embded(in: self, withContent: item.mainImageName)
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



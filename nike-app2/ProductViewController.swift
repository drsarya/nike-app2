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
    
    lazy var navigationView: UINavigationBar = {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y:0, width: view.frame.size.width, height:44))
        let navItem = UINavigationItem(title: "HII")
        let backItem = UIBarButtonItem()
        backItem.title = "BACK"
        navItem.backBarButtonItem = backItem
        navBar.setItems([navItem], animated:false)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        //navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    lazy var allProductImagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
        view.backgroundColor = .lightGray
        view.addSubview(navigationView)
        view.addSubview(allProductImagesCollectionView)
        view.addSubview(productTypesCollectionView)
        
        NSLayoutConstraint.activate([
            
            //navigationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
           // navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 16),
           // navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            navigationView.heightAnchor.constraint(equalToConstant: 50),
            
            allProductImagesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            allProductImagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 16),
            allProductImagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            allProductImagesCollectionView.heightAnchor.constraint(equalToConstant: 350),
            
            productTypesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16),
            productTypesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 16),
            productTypesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productTypesCollectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    struct Item {
        var mainImageName: ProductContent
        var nestedImagesNames: [ProductContent]
        var title: String
    }
    
    let items: [Item] = [
        Item(mainImageName: ProductContent(imageName: "p1_0"),
             nestedImagesNames: [ProductContent(imageName:"p1_1"),                                 ProductContent(imageName:"p1_2"), ProductContent(imageName:"p1_3")], title: "Product 1" ),
        Item(mainImageName: ProductContent(imageName:"p2_0"), nestedImagesNames: [ProductContent(imageName:"p2_1"), ProductContent(imageName:"p2_2"), ProductContent(imageName:"p2_3")], title: "Product 2" )
        
    ]
    
    var selectedProduct: Item?
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
        cell.backgroundColor = .systemPink
        cell.contentView.backgroundColor = .systemBlue
        cell.alpha = 0.5
        return cell
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  sizeForItemAt indexPath: IndexPath) -> CGSize{
        if(collectionView == self.allProductImagesCollectionView){
            return CGSize(width: 300, height:300)
        }
        return CGSize(width: 170, height:170)
    }
}



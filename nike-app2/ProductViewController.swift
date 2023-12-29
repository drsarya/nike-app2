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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        setupView()
    }

    private func setupView(){
        view.addSubview(collectionView)
 
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.heightAnchor.constraint(equalToConstant: 320)
        ])
    }
    
    struct Item: ProductContent{
         var mainImageName: String
         var nestedImagesNames: [String]
         var title: String
    }

    let items: [ProductContent] = [
        Item(mainImageName: "p1_0",nestedImagesNames: ["p1_1", "p1_2", "p1_3"], title: "Product 1" ),
        Item(mainImageName: "p2_0",nestedImagesNames: ["p2_1", "p2_2", "p2_3"], title: "Product 2" ),
        Item(mainImageName: "p2_0",nestedImagesNames: ["p2_1", "p2_2", "p2_3"], title: "Product 2" ),
    
    ]
}

extension ProductViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductCollectionViewCell else {
            fatalError("Could not dequeue cell")
        }
        let item = items[indexPath.row]
        cell.embded(in: self, withContent: item)
        return cell
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 170, height:170)
    }
}



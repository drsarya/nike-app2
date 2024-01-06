//
//  ProductCollectionViewCell.swift
//  nike-app2
//
//  Created by darya on 29.12.2023.
//  Copyright © 2023 darya. All rights reserved.
//

import SwiftUI
import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier = "ProductCollectionViewCell"
    
    var host: UIHostingController<ProductCard>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    func embded(in parent:UIViewController, imageUrl: String){
        
        if let host = self.host {
            host.rootView = ProductCard(imageUrl: imageUrl)
            host.view.layoutIfNeeded()
        } else{
            let host = UIHostingController(rootView: ProductCard(imageUrl: imageUrl))
            
            parent.addChild(host)
            host.didMove(toParent:parent)
            
            host.view.frame = self.contentView.bounds
            self.contentView.addSubview(host.view)
            print("Cell has been added to parent UIVIewController")
            self.host = host
        }
    }
    
    deinit {
        host?.willMove(toParent: nil)
        host?.view.removeFromSuperview()
        host?.removeFromParent()
        host = nil
        print("Cell has been cleaned up")
    }
}

//
//  ApiService.swift
//  nike-app2
//
//  Created by darya on 06.01.2024.
//  Copyright © 2024 darya. All rights reserved.
//

import UIKit

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    func getProductById(id: Int, completition: @escaping (Result<ProductViewController.Product, Error>)-> Void ){
        let productInfoUrl = "https://my-json-server.typicode.com/drsarya/ios-data/products/" + String(id)
        
        guard let url = URL(string: productInfoUrl) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) {
            ( data, response, error ) in
            if let error = error {
                completition(.failure(error))
                print("DataTask error" + String(error.localizedDescription))
                return
            }
            
            guard let response = response as? HTTPURLResponse else{
                print("Empty Response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            do{
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ProductViewController.Product.self, from: data)
                
                DispatchQueue.main.async {
                    completition(.success(jsonData))
                }
            } catch let error {
                completition(.failure(error))
            }
        }
        dataTask?.resume()
    }
}

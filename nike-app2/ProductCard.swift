//
//  ProductCard.swift
//  nike-app2
//
//  Created by darya on 29.12.2023.
//  Copyright © 2023 darya. All rights reserved.
//

import SwiftUI

struct ProductContent {
    var imageName: String
    init(imageName: String){
        self.imageName = imageName
    }
}

struct ProductCard: View {

    let content: ProductContent
    var body: some View {
        VStack (alignment: .leading, spacing: 2 ){
            Image(content.imageName)
            .resizable()
            .padding(.horizontal, 20)
            .scaledToFit()
        }
    }
}


//struct ProductCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductCard()
//    }
//}

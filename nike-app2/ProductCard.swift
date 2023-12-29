//
//  ProductCard.swift
//  nike-app2
//
//  Created by darya on 29.12.2023.
//  Copyright © 2023 darya. All rights reserved.
//

import SwiftUI

protocol ProductContent {
    var mainImageName: String {get}
}

struct ProductCard: View {

    let content: ProductContent
    var body: some View {
        VStack (alignment: .leading, spacing: 2 ){
            Image(content.mainImageName)
            .resizable()
                .frame(width: 170, height:170, alignment: .bottom)
            
        }
    }
}


//struct ProductCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductCard()
//    }
//}

//
//  ProductCard.swift
//  nike-app2
//
//  Created by darya on 29.12.2023.
//  Copyright © 2023 darya. All rights reserved.
//

import SwiftUI

struct ProductCard: View {

    let imageUrl: String
    
    var body: some View {
        VStack (alignment: .leading, spacing: 2 ){
            AsyncImage(
                url: URL(string: imageUrl)!,
                placeholder: Text("Loading ...")
            )
        }
    }
}


//struct ProductCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductCard()
//    }
//}

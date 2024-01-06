//
//  ImageLoader.swift
//  nike-app2
//
//  Created by darya on 06.01.2024.
//  Copyright © 2024 darya. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    deinit {
        cancel()
    }
    
    private var cancellable: AnyCancellable?
    
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}

struct AsyncImage<Placeholder: View>: View {
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Placeholder
    
    init(url: URL,  placeholder:  Placeholder) {
        self.placeholder = placeholder
        _loader = ObservedObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
                    .padding(.horizontal, 10)
                    .scaledToFit()
            } else {
                placeholder
            }
        }
    }
}




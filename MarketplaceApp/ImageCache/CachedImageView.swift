//
//  CachedImageView.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import SwiftUI

struct CachedImageView: View {
    
    let urlString: String?
    
    @StateObject private var loader = ImageLoader()
    
    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                ProgressView()
            }
        }
        .task {
            if let urlString = urlString {
                await loader.load(from: urlString)
            }
        }
    }
}

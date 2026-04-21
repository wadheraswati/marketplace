//
//  DataImageView.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-21.
//

import SwiftUI

struct DataImageView: View {
    let imageData: Data? // Assume this comes from a database or API

    var body: some View {
        if let data = imageData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        } else {
            // Placeholder for invalid data
            ProgressView()
        }
    }
}

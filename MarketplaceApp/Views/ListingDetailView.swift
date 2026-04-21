//
//  ListingDetailView.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import SwiftUI

struct ListingDetailView: View {
    
    let listing: Listing
    let onFavoriteTap: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ZStack(alignment: .bottomTrailing) {
                    
                    CachedImageView(urlString: listing.imageURL)
                        .frame(height: 280)
                        .clipped()
                    
                    Button {
                        onFavoriteTap()
                    } label: {
                        Image(systemName: listing.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(.white)
                            .padding()
                            .background(.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .padding()
                }
                Text("$\(listing.price, specifier: "%.2f")")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.black)
                
                Text(descriptionText)
                    .font(.subheadline)
                
            }
            .padding()
        }
        .navigationTitle(listing.title)
    }
}

private var descriptionText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s."

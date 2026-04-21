//
//  ListingRowView.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import SwiftUI

struct ListingRowView: View {
    
    let listing: Listing
    let onFavoriteTap: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            
            CachedImageView(urlString: listing.imageURL)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(listing.title)
                    .font(.headline)
                
                Text("$\(listing.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
            }
            
            Spacer()
            Button(action: onFavoriteTap) {
                Image(systemName: listing.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
            .buttonStyle(.plain)
        }
    }
}

struct MyListingRowView: View {
    
    let listing: MyListing
    
    var body: some View {
        HStack(spacing: 12) {
            
            DataImageView(imageData: listing.imageData)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(listing.title)
                    .font(.headline)
                
                Text("$\(listing.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
            }
            .buttonStyle(.plain)
        }
    }
}

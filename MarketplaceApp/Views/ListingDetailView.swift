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
                CachedImageView(urlString: listing.imageURL)
                    .frame(height: 250)
                    .cornerRadius(12)
                
                Text(listing.title)
                    .font(.title)
                    .bold()
                
                Text("$\(listing.price, specifier: "%.2f")")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                SyncStatusBadge(status: listing.syncStatus)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
    }
}

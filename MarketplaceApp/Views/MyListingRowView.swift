//
//  MyListingRowView.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-21.
//

import SwiftUI


struct MyListingRowView: View {
    
    let listing: MyListing
    var syncTapped: () -> Void
    
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
            Spacer()
            Button {
                if listing.syncStatus == .pending { syncTapped() }
            } label: {
                if listing.syncStatus == .pending {
                    Image(systemName: "arrow.clockwise.circle")
                        .foregroundColor(.red)
                } else {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
            .frame(width: 50, height: 50)
        }
    }
}

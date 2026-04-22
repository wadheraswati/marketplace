//
//  ListingsView.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import SwiftUI

struct ListingsView: View {
    
    @StateObject var viewModel: ListingsViewModel
    
    var body: some View {
        NavigationStack {
            if viewModel.listings.isEmpty {
                Text("No listings available")
            } else {
                List {
                    ForEach(viewModel.listings) { listing in
                        NavigationLink {
                            ListingDetailView(listing: listing,
                                              onFavoriteTap: {
                                viewModel.toggleFavorite(listing)
                            })
                        } label: {
                            ListingRowView(listing: listing,
                                           onFavoriteTap: {
                                viewModel.toggleFavorite(listing)
                            })
                        }
                    }
                }
                .listRowSeparator(.hidden)
                .navigationTitle("Marketplace")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink {
                            MyListingsView()
                        } label: {
                            Text("Sell")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            FavoritesView(onFavoriteTap: { listing in
                                viewModel.toggleFavorite(listing)
                            })
                        } label: {
                            Image(systemName: "heart")
                        }
                        .buttonBorderShape(.capsule)
                    }
                }
            }
        }
        .task {
            await viewModel.fetchListings()
        }
    }
}

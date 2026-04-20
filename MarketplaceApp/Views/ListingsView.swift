//
//  ListingsView.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import SwiftUI

import SwiftUI

struct ListingsView: View {
    
    @StateObject var viewModel: ListingsViewModel
    
    var body: some View {
        NavigationStack {
            if viewModel.listings.isEmpty {
                Text("No listings available")
            } else {
                List {
                    LazyVStack(spacing: 12) {
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
                                }
                                )
                            }
                        }
                    }
                }
                .navigationTitle("Marketplace")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            CreateListingView()
                        } label: {
                            Image(systemName: "plus")

                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .padding()
                    }
                }
            }
        }
        
        .task {
            await viewModel.loadListings()
        }
    }
}

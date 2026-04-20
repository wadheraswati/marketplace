//
//  FavoritesView.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//


import SwiftUI

struct FavoritesView: View {
    
    @StateObject var viewModel = FavoritesViewModel(repository: Repository())
    let onFavoriteTap: () -> Void

    var body: some View {
        List(viewModel.favorites) { listing in
            ListingRowView(
                listing: listing,
                onFavoriteTap: {
                    onFavoriteTap()
                    viewModel.refresh()
                }
            )
        }
        .navigationTitle("Favorites")
        .task {
            await viewModel.loadFavorites()
        }
    }
}

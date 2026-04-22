//
//  MyListingsView.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-21.
//

import SwiftUI
struct MyListingsView: View {
    @StateObject var viewModel = MyListingsViewModel(repository: MyListingRepository())
    
    var body: some View {
        NavigationStack {
            List {
                if viewModel.listings.isEmpty {
                    Text("No items to sell at the moment.")
                } else {
                    ForEach(viewModel.listings, id: \.id) { listing in
                        MyListingRowView(listing: listing, syncTapped: {
                            viewModel.syncListing(listing)
                        })
                    }
                }
            }
            .navigationTitle("My Listings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        CreateListingView()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    }
                    .buttonBorderShape(.capsule)
                }
            }
        }
        .task {
            await viewModel.loadListings()
        }
    }
}

//
//  MyListingsView.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-21.
//

import SwiftUI
struct MyListingsView: View {
    @StateObject var viewModel: ListingsViewModel

    var body: some View {
        NavigationStack {
            if viewModel.listings.isEmpty {
                Text("You are not selling anything")
            } else {
                
            }
        }
    }
}

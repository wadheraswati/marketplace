//
//  MarketplaceApp.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import SwiftUI

@main
struct MarketplaceApp: App {
    var body: some Scene {
        WindowGroup {
            ListingsView(viewModel: ListingsViewModel(repository: Repository()))
        }
    }
}

//
//  MarketplaceApp.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import SwiftUI

@main
struct MarketplaceApp: App {
    init() {
        NetworkMonitor.shared.start()
        MyListingRepository().handleAppLaunch()
    }
    var body: some Scene {
        WindowGroup {
            ListingsView(viewModel: ListingsViewModel(repository: Repository()))
        }
    }
}

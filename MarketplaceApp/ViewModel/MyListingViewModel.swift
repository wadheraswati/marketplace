//
//  MyListingViewModel.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-21.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class MyListingsViewModel: ObservableObject {
    @Published var listings: [MyListing] = []
    
    private let repository: MyListingRepositoryProtocol
    
    init(repository: MyListingRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadListings() async {
        do {
            listings = try await repository.fetchListings()
        } catch {
            print("API Error: \(error)")
        }
    }
}

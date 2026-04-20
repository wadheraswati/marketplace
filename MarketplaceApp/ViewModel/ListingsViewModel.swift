//
//  ListingsViewModel.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class ListingsViewModel: ObservableObject {
    @Published var listings: [Listing] = []
    
    private let repository: ListingRepositoryProtocol
    
    init(repository: ListingRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadListings() async {        
        do {
            listings = try await repository.fetchListings()
        } catch {
            print("API Error: \(error)")
        }
    }
    
    func toggleFavorite(_ listing: Listing) {
        repository.toggleFavorite(listing)
    }
}

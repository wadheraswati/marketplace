//
//  FavoritesViewModel.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//


import Foundation
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {
    
    @Published var favorites: [Listing] = []
    
    private let repository: ListingRepositoryProtocol
    
    init(repository: ListingRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadFavorites() async {
        do {
            favorites = try await repository
                .fetchListings()
                .filter { $0.isFavorite }
        } catch {
            print("error - \(error)")
        }
    }

    func refresh() {
        Task {
            await loadFavorites()
        }
    }
}

//
//  ListingRepositoryMock.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-22.
//

import XCTest
@testable import MarketplaceApp

final class ListingRepositoryMock: ListingRepositoryProtocol {
    func fetchListings() async throws -> [Listing] {
        return [Listing(id: UUID(),
                        title: "Test Title",
                        price: 100,
                        isFavorite: false,
                        updatedAt: .now)]
    }
    
    func toggleFavorite(_ listing: Listing) {
        // update in DB
    }
}

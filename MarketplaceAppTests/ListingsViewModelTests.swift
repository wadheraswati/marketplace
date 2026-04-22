//
//  EventViewModelTests.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-22.
//

import XCTest
@testable import MarketplaceApp

class ListingsViewModelTests: XCTestCase {
    @MainActor
    func testFetchListings() async {
        // Given
        let mock = ListingRepositoryMock()
        let viewModel = ListingsViewModel(repository: mock)
        
        // Then
        XCTAssertTrue(viewModel.listings.isEmpty)
        
        // When
        await viewModel.fetchListings()
        
        // Then
        XCTAssertFalse(viewModel.listings.isEmpty)
    }
    
    @MainActor
    func testToggleFavorite() async {
        // Given
        let mock = ListingRepositoryMock()
        let viewModel = ListingsViewModel(repository: mock)
        
        // When
        await viewModel.fetchListings()
        viewModel.toggleFavorite(viewModel.listings[0])
        
        // Then
        XCTAssertTrue(viewModel.listings[0].isFavorite)
    }
}

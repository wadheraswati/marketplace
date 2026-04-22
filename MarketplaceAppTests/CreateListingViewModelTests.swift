//
//  CreateListingViewModelTests.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-22.
//

import XCTest
@testable import MarketplaceApp

@MainActor
final class CreateListingViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCreateListing() async {
        // Given
        let mock = CreateListingRepositoryMock()
        let viewModel = CreateListingViewModel(repository: mock)
        
        // When
        viewModel.title = "Test Item"
        viewModel.price = "100"
        
        let expectation = XCTestExpectation(description: "expectation")

        Task {
            await viewModel.save()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)
        
        // Then
        XCTAssertTrue(viewModel.shouldDismiss)
    }
}

//
//  CreateListingRepositoryMock.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-22.
//

@testable import MarketplaceApp

final class CreateListingRepositoryMock: CreateListingRepositoryProtocol {
    var didCreateListing = false
    func createListing(listing: MyListing) async throws {
        didCreateListing = true
    }

}

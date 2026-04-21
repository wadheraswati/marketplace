//
//  CreateListingRepository.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-21.
//

protocol CreateListingRepositoryProtocol {
    func createListing(listing: MyListing) async throws
}

final class CreateListingRepository: CreateListingRepositoryProtocol {
    let listingDataManager = MyListingDataManager.shared

    func createListing(listing: MyListing) async throws {
        do {
            try await NetworkManager.shared.request(
                endpoint: .uploadListing(listing: listing),
                responseType: Bool.self)
        } catch {
            listingDataManager.saveListingInDB(listing)
            print("create listing failed - \(error)")
        }
    }
}

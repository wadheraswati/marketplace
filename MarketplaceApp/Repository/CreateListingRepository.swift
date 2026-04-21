//
//  CreateListingRepository.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-21.
//

protocol CreateListingRepositoryProtocol {
    func createListing(listing: MyListing) async throws -> Bool
}

final class CreateListingRepository: CreateListingRepositoryProtocol {
    
    func createListing(listing: MyListing) async throws -> Bool {
        do {
            let status = try await NetworkManager.shared.request(
                endpoint: .uploadListing(listing: listing),
                responseType: Bool.self)
            return status
        } catch {
            print("create listing failed - \(error)")
        }
        return false
    }
}

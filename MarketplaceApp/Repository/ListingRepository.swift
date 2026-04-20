//
//  ListingRepository.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import CoreData
import Combine

protocol ListingRepositoryProtocol {
    func fetchListings() async throws -> [Listing]
    func createListing(_ listing: Listing)
    func toggleFavorite(_ listing: Listing)
}

final class Repository: ListingRepositoryProtocol {
    
    static let repo = Repository()
    let coreDataManager = CoreDataManager.shared
    
    @Published var listings: [Listing] = []
    
    func fetchListings() async throws -> [Listing] {
        do {
            return try await NetworkManager.shared.request(
                endpoint: .getListings,
                responseType: [Listing].self
            )
        }
        catch {
            return try await fetchListingsFromLocal()
        }
    }
    
    private func fetchListingsFromLocal() async throws -> [Listing] {
        do {
            let listings = try await coreDataManager.fetchListingsFromDB()
            guard !listings.isEmpty else {
                return try await loadListingsFromLocalFile()
            }
            return listings
        } catch {
            return try await loadListingsFromLocalFile()
        }
    }
    
    private func loadListingsFromLocalFile() async throws -> [Listing] {
        guard let url = Bundle.main.url(forResource: "Listings", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let listings = try decoder.decode([Listing].self, from: data)
            coreDataManager.saveListingsInDB(listings)
            return listings
        } catch {
            print(error)
        }
        return []
    }
    
    func createListing(_ listing: Listing) {
        // Pending
    }
    
    func toggleFavorite(_ listing: Listing) {
        coreDataManager.update(listing)
    }
}

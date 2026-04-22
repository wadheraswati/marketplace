//
//  MyListingRepository.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-21.
//

import CoreData
import Combine

protocol MyListingRepositoryProtocol {
    func fetchListings() async throws -> [MyListing]
    func update(listing: MyListing) async throws
}

final class MyListingRepository: MyListingRepositoryProtocol {
    
    static let repo = MyListingRepository()
    let listingDataManager = MyListingDataManager.shared
    
    @Published var listings: [MyListing] = []
    
    init() {
        observeNetwork()
    }
    
    func handleAppLaunch() {
        Task {
            try await syncIfNeeded()
        }
    }
    
    private func observeNetwork() {
        NetworkMonitor.shared.onReconnect = { [weak self] in
            Task {
                try await self?.syncIfNeeded()
            }
        }
    }
    
    func fetchListings() async throws -> [MyListing] {
        do {
            let listings = try await NetworkManager.shared.request(
                endpoint: .getListings,
                responseType: [MyListing].self
            )
            let localListings = try await fetchListingsFromLocal()
            return listings + localListings
        }
        catch {
            return try await fetchListingsFromLocal()
        }
    }
    
    private func fetchListingsFromLocal() async throws -> [MyListing] {
        let listings = listingDataManager.fetchListingsFromDB()
        return listings
    }
    
    func syncIfNeeded() async throws {
        guard NetworkMonitor.shared.isConnected else { return }
        
        let pendingListings = listingDataManager.fetchPendingListingsFromDB()
        for listing in pendingListings {
            try await update(listing: listing)
        }
    }
    
    func update(listing: MyListing) async throws {
        do {
            let success = try await NetworkManager.shared.request(
                endpoint: .uploadListing(listing: listing),
                responseType: Bool.self)
            var currentListing = listing
            currentListing.syncStatus = success ? .synced : .pending
            listingDataManager.update(currentListing)
        } catch {
            print("upload listing failed - \(error)")
        }
    }
}

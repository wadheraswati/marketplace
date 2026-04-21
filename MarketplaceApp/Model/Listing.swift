//
//  Listing.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import Foundation
import CoreData

struct Listing: Identifiable, Codable {
    let id: UUID
    var title: String
    var price: Double
    var imageURL: String?
    var isFavorite: Bool
    var updatedAt: Date
    var syncStatus: SyncStatus
}

enum SyncStatus: String, Codable {
    case pending
    case syncing
    case synced
    case failed
}

// Entity → Model
extension Listing {
    init(entity: ListingModel) {
        self.init(
            id: entity.id ?? UUID(),
            title: entity.title ?? "",
            price: entity.price,
            imageURL: entity.imageURL ?? "",
            isFavorite: entity.isFavorite,
            updatedAt: entity.updatedAt ?? .now,
            syncStatus: SyncStatus(rawValue: entity.syncStatus ?? SyncStatus.pending.rawValue) ?? SyncStatus.pending
        )
    }
}

extension ListingModel {

    func toDomain() -> Listing {
        Listing(
            id: id ?? UUID(),
            title: title ?? "",
            price: price,
            imageURL: imageURL,
            isFavorite: isFavorite,
            updatedAt: updatedAt ?? Date(),
            syncStatus: SyncStatus(rawValue: syncStatus ?? "pending") ?? .pending
        )
    }

    func update(from listing: Listing) {
        id = listing.id
        title = listing.title
        price = listing.price
        imageURL = listing.imageURL
        isFavorite = listing.isFavorite
        updatedAt = listing.updatedAt
        syncStatus = listing.syncStatus.rawValue
    }
}

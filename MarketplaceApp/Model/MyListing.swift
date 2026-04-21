//
//  MyListing.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-21.
//

import Foundation
import CoreData

struct MyListing: Identifiable, Codable {
    let id: UUID
    var title: String
    var price: Double
    var imageData: Data?
    var updatedAt: Date
    var syncStatus: SyncStatus
}

enum SyncStatus: String, Codable {
    case pending
    case synced
}

// Entity → Model
extension MyListing {
    init(entity: MyListingModel) {
        self.init(
            id: entity.id ?? UUID(),
            title: entity.title ?? "",
            price: entity.price,
            imageData: entity.imageData,
            updatedAt: entity.updatedAt ?? .now,
            syncStatus: SyncStatus(rawValue: entity.syncStatus ?? SyncStatus.pending.rawValue) ?? SyncStatus.pending
        )
    }
}

extension MyListingModel {
    func toDomain() -> MyListing {
        MyListing(
            id: id ?? UUID(),
            title: title ?? "",
            price: price,
            imageData: imageData,
            updatedAt: updatedAt ?? Date(),
            syncStatus: SyncStatus(rawValue: syncStatus ?? "pending") ?? .pending
        )
    }

    func update(from listing: MyListing) {
        id = listing.id
        title = listing.title
        price = listing.price
        imageData = listing.imageData
        updatedAt = listing.updatedAt
        syncStatus = listing.syncStatus.rawValue
    }
}

//
//  CoreDataManager.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import CoreData

protocol CoreDataProtocol {
    func fetchListingsFromDB() async throws -> [Listing]
    func saveListingsInDB(_ listings: [Listing])
    func update(_ listing: Listing)
}

final class CoreDataManager {
    static let shared = CoreDataManager()

    let container: NSPersistentContainer

    var context: NSManagedObjectContext {
        container.viewContext
    }

    private init() {
        container = NSPersistentContainer(name: "ListingModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData failed: \(error)")
            }
        }
    }
    
    func fetchListingsFromDB() async throws -> [Listing] {
        let context = CoreDataManager.shared.context
        
        let request: NSFetchRequest<ListingModel> = ListingModel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "updatedAt", ascending: true)]
        
        do {
            let entities = try context.fetch(request)
            return entities.map { Listing(entity: $0) }
        } catch {
            print("Fetch error: \(error)")
        }
        return []
    }
    
    func saveListingsInDB(_ listings: [Listing]) {
        let context = CoreDataManager.shared.context

        for listing in listings {
            let entity = ListingModel(context: context)
            entity.update(from: listing)
        }
        save()
    }
    
    func save() {
        if context.hasChanges {
            try? context.save()
        }
    }
    
    func update(_ listing: Listing) {
        let context = CoreDataManager.shared.context
        let request: NSFetchRequest<ListingModel> = ListingModel.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", listing.id as CVarArg)
        
        do {
            if let entity = try context.fetch(request).first {
                entity.syncStatus = listing.syncStatus.rawValue
                entity.isFavorite = listing.isFavorite
                save()
            }
        } catch {
            print("Toggle error: \(error)")
        }
    }
}

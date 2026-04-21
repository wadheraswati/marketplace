//
//  MyListingDataManager.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-21.
//

import CoreData

final class MyListingDataManager {
    static let shared = MyListingDataManager()

    let container: NSPersistentContainer

    var context: NSManagedObjectContext {
        container.viewContext
    }

    private init() {
        container = NSPersistentContainer(name: "ListingModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("CoreData failed: \(error)")
            }
        }
    }
    
    func fetchListingsFromDB() -> [MyListing] {
        let context = MyListingDataManager.shared.context
        
        let request: NSFetchRequest<MyListingModel> = MyListingModel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "updatedAt", ascending: true)]
        
        let entities = try? context.fetch(request)
        return entities?.map { MyListing(entity: $0) } ?? []
    }
    
    func fetchPendingListingsFromDB() -> [MyListing] {
        let context = MyListingDataManager.shared.context
        
        let request: NSFetchRequest<MyListingModel> = MyListingModel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "syncStatus == pending", ascending: true)]
        
        let entities = try? context.fetch(request)
        return entities?.map { MyListing(entity: $0) } ?? []
    }
    
    func saveListingInDB(_ listing: MyListing) {
        let context = MyListingDataManager.shared.context
        let entity = MyListingModel(context: context)
        entity.update(from: listing)
        save()
    }
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    func update(_ listing: MyListing) {
        let context = MyListingDataManager.shared.context
        let request: NSFetchRequest<MyListingModel> = MyListingModel.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", listing.id as CVarArg)
        
        do {
            if let entity = try context.fetch(request).first {
                entity.syncStatus = listing.syncStatus.rawValue
                save()
            }
        } catch {
            print("Toggle error: \(error)")
        }
    }
}

//
//  CreateListingViewModel.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import Foundation
import Combine
import UIKit

@MainActor
final class CreateListingViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var price: String = ""
    @Published var selectedImage: UIImage?
    
    private let repository: ListingRepositoryProtocol
    private let imageCache = DiskCacheManager.shared
    
    init(repository: ListingRepositoryProtocol) {
        self.repository = repository
    }
    
    var isValid: Bool {
        guard !title.isEmpty,
              let priceValue = Double(price),
              priceValue > 0 else {
            return false
        }
        return true
    }
    
    func save() {
        guard isValid else { return }
        
        let id = UUID()
        
//        var localPath: String?
        
        if let image = selectedImage {
            let thumbnail = ThumbnailGenerator.generate(from: image)
            imageCache.save(thumbnail, forKey: "\(id).jpg")
        }
        
        let listing = Listing(
            id: id,
            title: title,
            price: Double(price) ?? 0,
            imageURL: nil,
            isFavorite: false,
            updatedAt: Date(),
        )
        
//        repository.createListing(listing)
        
        reset()
    }
    
    func reset() {
        title = ""
        price = ""
        selectedImage = nil
    }
    
    func pickImage() {
        // Hook this to PHPicker in View
    }
}

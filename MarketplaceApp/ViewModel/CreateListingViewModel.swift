//
//  CreateListingViewModel.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import Foundation
import Combine
import UIKit
import PhotosUI
import SwiftUI

@MainActor
final class CreateListingViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var price: String = ""

    @Published var selectedItem: PhotosPickerItem?
    @Published var selectedPhoto: Image?

    @Published var showAlert = false
    @Published var shouldDismiss = false

    private let repository: CreateListingRepositoryProtocol
    
    init(repository: CreateListingRepositoryProtocol) {
        self.repository = repository
    }
    
    var isValid: Bool {
        guard !title.isEmpty,
              let priceValue = Double(price.replacingOccurrences(of: "$", with: "")),
              priceValue > 0 else {
            return false
        }
        return true
    }
    
    func save() async {
        guard isValid else {
            return
        }
        
        let id = UUID()
        var imageData: Data? = nil
        
        if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
           imageData = data
        }
        
        let listing = MyListing(
            id: id,
            title: title,
            price: Double(price) ?? 0,
            imageData: imageData,
            updatedAt: Date(),
            syncStatus: .pending
        )
        do {
            try await repository.createListing(listing: listing)
            shouldDismiss = true
        } catch {
            print("create failed")
        }
    }
}

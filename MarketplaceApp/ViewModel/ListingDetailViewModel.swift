//
//  ListingDetailViewModel.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import Foundation
import Combine

@MainActor
final class ListingDetailViewModel: ObservableObject {
    
    @Published var listing: Listing
    
    private let repository: ListingRepositoryProtocol

    init(listing: Listing,
         repository: ListingRepositoryProtocol) {
        self.listing = listing
        self.repository = repository
    }
}

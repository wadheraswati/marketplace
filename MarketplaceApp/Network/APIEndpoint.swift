//
//  Untitled.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import Foundation

enum APIEndpoint {
    case getListings
    case getListingDetails(id: String)
}

extension APIEndpoint {
    var baseURL: String {
        return "https://api.yourlistingsapp.com"
    }
    
    var path: String {
        switch self {
        case .getListings:
            return "/listings"
        case .getListingDetails(let id):
            return "/event/\(id)"
        }
    }
    
    var method: String {
        switch self {
        case .getListings, .getListingDetails:
            return "GET"
        }
    }
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
}

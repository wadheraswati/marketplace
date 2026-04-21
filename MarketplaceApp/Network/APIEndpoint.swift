//
//  Untitled.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import Foundation

enum APIEndpoint {
    case getListings
    case getMyListings
    case uploadListing(listing: MyListing)
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
        case .getMyListings:
            return "/myListings"
        case .uploadListing:
            return "/upload"
        case .getListingDetails(let id):
            return "/event/\(id)"
        }
    }
    
    var method: String {
        switch self {
        case .getListings, .getMyListings, .getListingDetails:
            return "GET"
        case .uploadListing:
            return "POST"
        }
    }
    
    var body: Data? {
        switch self {
        case .uploadListing(let listing):
            return listing.body
        default:
            return nil

        }
    }
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
}

extension MyListing {
    var body: Data {
        var body = Data()
        let boundary = UUID().uuidString

        func append(_ string: String) {
            body.append(string.data(using: .utf8)!)
        }
        
        // Title
        append("--\(boundary)\r\n")
        append("Content-Disposition: form-data; name=\"title\"\r\n\r\n")
        append("\(self.title)\r\n")
        
        // Price
        append("--\(boundary)\r\n")
        append("Content-Disposition: form-data; name=\"price\"\r\n\r\n")
        append("\(self.price)\r\n")
        
        // Image
        if let imageData = self.imageData {
            append("--\(boundary)\r\n")
            append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n")
            append("Content-Type: image/jpeg\r\n\r\n")
            body.append(imageData)
            append("\r\n")
        }
        
        append("--\(boundary)--\r\n")
        
        return body
    }
}

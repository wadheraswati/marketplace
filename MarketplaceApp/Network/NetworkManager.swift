//
//  NetworkManager.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//


//
//  NetworkManager.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    @discardableResult
    func request<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type,
    ) async throws -> T {
        
        guard let url = endpoint.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.httpBody = endpoint.body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return try decoder.decode(T.self, from: data)
    }
}

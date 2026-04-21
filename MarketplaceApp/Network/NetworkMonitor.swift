//
//  NetworkMonitor.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-21.
//


import Network

final class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    
    var isConnected = false
    var onReconnect: (() -> Void)?
    
    func start() {
        monitor.pathUpdateHandler = { path in
            let wasDisconnected = !self.isConnected
            self.isConnected = path.status == .satisfied
            
            if self.isConnected && wasDisconnected {
                self.onReconnect?()
            }
        }
        
        monitor.start(queue: DispatchQueue.global())
    }
}
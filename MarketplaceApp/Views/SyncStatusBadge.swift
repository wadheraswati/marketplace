//
//  SyncStatusBadge.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//


import SwiftUI

struct SyncStatusBadge: View {
    
    let status: SyncStatus
    
    var body: some View {
        Text(statusText)
            .font(.caption)
            .padding(6)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(6)
    }
    
    private var statusText: String {
        switch status {
        case .pending: return "Pending"
        case .syncing: return "Syncing"
        case .synced: return "Synced"
        case .failed: return "Failed"
        }
    }
    
    private var backgroundColor: Color {
        switch status {
        case .pending: return .orange
        case .syncing: return .blue
        case .synced: return .green
        case .failed: return .red
        }
    }
}
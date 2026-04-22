//
//  CreateListingView.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import SwiftUI
import PhotosUI

struct CreateListingView: View {
    
    @StateObject var viewModel = CreateListingViewModel(repository: CreateListingRepository())
    @State private var isPickerPresented = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section() {
                TextField("Title", text: $viewModel.title)
                
                TextField("Price", text: $viewModel.price)
                    .keyboardType(.decimalPad)
                    .onChange(of: viewModel.price, { _, newValue in
                        viewModel.price = "$" + newValue.replacingOccurrences(of: "$", with: "")
                    })
            }
            
            Section {
                Button("Pick Image") {
                    isPickerPresented = true
                }
                .photosPicker(isPresented: $isPickerPresented, selection: $viewModel.selectedItem)
                .onChange(of: viewModel.selectedItem) {
                    Task {
                        if let data = try? await viewModel.selectedItem?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            viewModel.selectedPhoto = Image(uiImage: uiImage)
                        } else {
                            print("Failed")
                        }
                    }
                }
                
                if let image = viewModel.selectedPhoto {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                }
            }
        }
        
        .navigationTitle("Create Listing")
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Save") {
                    Task {
                        await
                        viewModel.save()
                    }
                }
                .onChange(of: viewModel.shouldDismiss) { _, newValue in
                    if newValue { dismiss() }
                }
                .disabled(!viewModel.isValid)
            }
        }
    }
}

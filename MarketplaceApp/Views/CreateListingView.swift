//
//  CreateListingView.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import SwiftUI

struct CreateListingView: View {
    
    @StateObject var viewModel = CreateListingViewModel(repository: Repository())
    
    var body: some View {
        Form {
            Section(header: Text("Details")) {
                TextField("Title", text: $viewModel.title)
                
                TextField("Price", text: $viewModel.price)
                    .keyboardType(.decimalPad)
            }
            
            Section {
                Button("Pick Image") {
                    viewModel.pickImage()
                }
                
                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                }
            }
            
            Section {
                Button("Save") {
                    viewModel.save()
                }
                .disabled(!viewModel.isValid)
            }
        }
        .navigationTitle("New Listing")
    }
}

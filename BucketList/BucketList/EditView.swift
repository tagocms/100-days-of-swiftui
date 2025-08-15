//
//  EditView.swift
//  BucketList
//
//  Created by Tiago Camargo Maciel dos Santos on 04/07/25.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    let location: Location
    let onSave: (Location) -> Void
    
    @State private var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Location name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                        
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                        
                    case .failed:
                        Text("Loading failed, please try again later.")
                    }
                }
            }
            .navigationTitle("Location Details")
            .toolbar {
                Button("Save") {
                    onSave(viewModel.createNewLocation())
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        _viewModel = State(initialValue: ViewModel(location: location))
    }
}

#Preview {
    EditView(location: .example) { _ in }
}

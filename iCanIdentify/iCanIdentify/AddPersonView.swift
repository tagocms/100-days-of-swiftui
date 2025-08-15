//
//  AddPersonView.swift
//  iCanIdentify
//
//  Created by Tiago Camargo Maciel dos Santos on 15/07/25.
//

import PhotosUI
import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var photoItem: PhotosPickerItem?
    @State private var photoImage: Image?
    @State private var personName = ""
    @State private var personSummary = ""
    
    @State private var isShowingAlert = false
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationStack {
            Form {
                if let photoItem {
                    Section {
                        if let photoImage {
                            photoImage
                                .resizable()
                                .scaledToFit()
                        } else {
                            ProgressView()
                        }
                        TextField("Name", text: $personName)
                        TextField("Summary", text: $personSummary)
                    }
                    .onAppear {
                        locationFetcher.start()
                        
                        Task {
                            if let photoImageData = try? await photoItem.loadTransferable(type: Image.self) {
                                photoImage = photoImageData
                            }
                        }
                    }
                } else {
                    PhotosPicker("Select a photo", selection: $photoItem)
                }
            }
            .alert("Name or summary cannot be empty", isPresented: $isShowingAlert) { }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    if let photoItem {
                        Button("Save") {
                            Task {
                                let photoData = try await photoItem.loadTransferable(type: Data.self)
                                if let photoData {
                                    if !personName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
                                        !personSummary.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                        if let location = locationFetcher.lastKnownLocation {
                                            let newPerson = Person(id: UUID(), name: personName, summary: personSummary, longitude: location.longitude, latitude: location.latitude, photo: photoData)
                                            modelContext.insert(newPerson)
                                            
                                            do {
                                                try modelContext.save()
                                            } catch { }
                                            
                                            dismiss()
                                        }
                                    } else {
                                        isShowingAlert.toggle()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddPersonView()
}

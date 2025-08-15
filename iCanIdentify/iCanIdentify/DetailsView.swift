//
//  DetailsView.swift
//  iCanIdentify
//
//  Created by Tiago Camargo Maciel dos Santos on 15/07/25.
//

import MapKit
import SwiftData
import SwiftUI

struct DetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    let person: Person
    
    @State private var newName: String
    @State private var newSummary: String
    
    @State private var isShowingAlert = false
    @State private var isEditingDisabled = true
    
    let location: CLLocationCoordinate2D
    let mapCameraPosition: MapCameraPosition
    
    var body: some View {
        Form {
            Section("Photo and location") {
                Group {
                    if let photoUIImage = person.convertDataToImage() {
                        HStack {
                            Spacer()
                            Image(uiImage: photoUIImage)
                                .resizable()
                                .scaledToFit()
                            Spacer()
                        }
                    } else {
                        ContentUnavailableView("Image Unavailable", systemImage: "photo.badge.exclamationmark")
                    }
                }
                .frame(height: 200)
                
                Group {
                    Map(initialPosition: mapCameraPosition) {
                        Marker(person.name, coordinate: location)
                    }
                }
                .frame(height: 200)
                .clipShape(.rect(cornerRadius: 20))
            }
            
            Section("Personal information") {
                Group {
                    TextField("Name", text: $newName)
                    TextField("Summary", text: $newSummary)
                }
                .disabled(isEditingDisabled)
            }
        }
        .alert("Name or summary cannot be empty", isPresented: $isShowingAlert) { }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(isEditingDisabled ? "Edit" : "Save") {
                    isEditingDisabled ? isEditingDisabled.toggle() : savePerson()
                }
            }
        }
    }
    
    init(person: Person) {
        self.person = person
        self._newName = State(initialValue: person.name)
        self._newSummary = State(initialValue: person.summary)
        
        self.location = CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude)
        
        let coordinateRegion = MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
        
        self.mapCameraPosition = MapCameraPosition.region(coordinateRegion)
    }
    
    func savePerson() {
        if !newName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !newSummary.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            
            person.name = newName
            person.summary = newSummary
            
            do {
                try modelContext.save()
            } catch {
                //
            }
            
            isEditingDisabled.toggle()
        } else {
            isShowingAlert.toggle()
        }
    }
}

#Preview {
    DetailsView(person: Person(id: UUID(), name: "Tiago", summary: "Teste", longitude: CLLocationCoordinate2D().longitude, latitude: CLLocationCoordinate2D().latitude, photo: Data()))
}

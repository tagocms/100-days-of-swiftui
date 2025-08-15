//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Tiago Camargo Maciel dos Santos on 08/07/25.
//

import Foundation
import LocalAuthentication
import MapKit
import SwiftUI

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedLocation: Location?
        var isUnlocked = false
        var errorTitle = ""
        var errorMessage = ""
        var isShowingErrorAlert = false
        
        var mapStyleEnum = MapStyleEnum.standard
        var mapStyle: MapStyle {
            switch mapStyleEnum {
            case .standard:
                .standard
            case .hybrid:
                .hybrid
            case .imagery:
                .imagery
            }
        }
        
        let fileName = "SavedPlaces"
        
        init() {
            do {
                let data = try FileManager.readDataFromFile(fileName: fileName)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                print("Unable to load data.")
                locations = []
            }
        }
        
        func saveLocations() {
            do {
                try FileManager.writeDataToFile(rawData: locations, fileName: fileName)
            } catch {
                print("Unable to write data.")
            }
        }
        
        func addLocation(at coordinate: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
            
            locations.append(newLocation)
            saveLocations()
        }
        
        func updateLocations(newLocation: Location) {
            guard let selectedLocation else { return }
            
            if let index = locations.firstIndex(of: selectedLocation) {
                locations[index] = newLocation
            }
            
            saveLocations()
        }
        
        func setSelectedLocation(_ location: Location) {
            selectedLocation = location
        }
        
        func authenticate() {
            let context = LAContext()
            var NSError: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &NSError) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                        self.errorTitle = "Authentication Failed"
                        self.errorMessage = "Unable to authenticate."
                        self.isShowingErrorAlert.toggle()
                    }
                }
            } else {
                // no biometrics
                self.errorTitle = "No biometrics"
                self.errorMessage = "Your device does not support biometrics authentication."
                self.isShowingErrorAlert.toggle()
            }
        }
    }
}

enum MapStyleEnum: String, CaseIterable {
    case standard = "Standard"
    case imagery = "Imagery"
    case hybrid = "Hybrid"
}

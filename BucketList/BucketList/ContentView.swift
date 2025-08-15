//
//  ContentView.swift
//  BucketList
//
//  Created by Tiago Camargo Maciel dos Santos on 02/07/25.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var startLocation = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -15.83, longitude: -47.86),
            span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30)
        )
    )
    @State private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            MapReader { proxy in
                Map(initialPosition: startLocation) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .onTapGesture {
                                    viewModel.selectedLocation = location
                                }
                        }
                    }
                }
                .mapStyle(viewModel.mapStyle)
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedLocation) { location in
                    EditView(location: location) { newLocation in
                        viewModel.updateLocations(newLocation: newLocation)
                    }
                }
            }
            
            Picker("Map Style", selection: $viewModel.mapStyleEnum) {
                ForEach(MapStyleEnum.allCases, id: \.self) { style in
                    Text(style.rawValue)
                }
            }
            .pickerStyle(.segmented)
        } else {
            Button("Unlock places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert(viewModel.errorTitle, isPresented: $viewModel.isShowingErrorAlert) {
                    Button("OK") { }
                } message: {
                    Text(viewModel.errorMessage)
                }
        }
    }
}

#Preview {
    ContentView()
}

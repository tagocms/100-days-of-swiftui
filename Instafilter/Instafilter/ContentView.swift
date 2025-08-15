//
//  ContentView.swift
//  Instafilter
//
//  Created by Tiago Camargo Maciel dos Santos on 25/06/25.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false
    
    @Environment(\.requestReview) var requestReview
    @AppStorage("filterCount") private var filterCount = 0
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // image
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                
                
                VStack {
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity, applyProcessing)
                    }
                    HStack {
                        Text("Radius")
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius, applyProcessing)
                    }
                    HStack {
                        Text("Scale")
                        Slider(value: $filterScale)
                            .onChange(of: filterScale, applyProcessing)
                    }
                }
                .padding(.vertical)
                .disabled(processedImage == nil ? true : false)
                
                HStack {
                    Button("Change filter", action: changeFilter)
                        .disabled(processedImage == nil ? true : false)
                    
                    Spacer()
                    
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
            }
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(.crystallize())}
                Button("Edges") { setFilter(.edges())}
                Button("Gaussian Blur") { setFilter(.gaussianBlur())}
                Button("Pixellate") { setFilter(.pixellate())}
                Button("Sepia Tone") { setFilter(.sepiaTone())}
                Button("Unsharp Mask") { setFilter(.unsharpMask())}
                Button("Vignette") { setFilter(.vignette())}
                
                Button("Bloom") { setFilter(.bloom())}
                Button("Dot Screen") { setFilter(.dotScreen())}
                Button("Color Monochrome") { setFilter(.colorMonochrome())}
                Button("Cancel", role: .cancel) { }
            }
            .padding([.horizontal, .bottom])
        }
    }
    
    func changeFilter() {
        showingFilters = true
    }
    
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        
        if filterCount >= 20 {
            requestReview()
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        print(currentFilter.name)
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(currentFilter.name == "CIEdges" ? filterIntensity * 100 : filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 100, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputSharpnessKey) {
            currentFilter.setValue(filterIntensity * 100, forKey: kCIInputSharpnessKey)
        }
        if inputKeys.contains(kCIInputWidthKey) {
            currentFilter.setValue(filterScale * 100, forKey: kCIInputWidthKey)
        }

        
        guard let ciOutputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(ciOutputImage, from: ciOutputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
        
    }
}

#Preview {
    ContentView()
}

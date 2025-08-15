//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Tiago Camargo Maciel dos Santos on 11/08/25.
//

import SwiftUI

struct ContentView: View {
    @State private var resorts = Resort.allResorts
    @State private var searchText = ""
    @State private var favorites = Favorites()
    @State private var sortItem = CustomSortItem.defaultSort
    @State private var sortOrder = CustomSortOrder.ascending
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedStandardContains(searchText) ||
                $0.country.localizedStandardContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu("Sort by", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort by", selection: $sortItem) {
                            ForEach(CustomSortItem.allCases, id: \.self) { item in
                                Text(item.rawValue)
                            }
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        switch sortOrder {
                        case .ascending:
                            sortOrder = .descending
                        case .descending:
                            sortOrder = .ascending
                        }
                    } label: {
                        Image(systemName: sortOrder == .ascending ? "arrow.down" : "arrow.up")
                    }
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
        .onChange(of: sortItem, sortList)
        .onChange(of: sortOrder, sortList)

    }
    
    func sortList() {
        if sortItem == .defaultSort {
            resorts = Resort.allResorts
        } else {
            resorts.sort { left, right in
                if sortItem == .name {
                    return left.name < right.name
                } else {
                    return left.country < right.country
                }
            }
        }
        
        if sortOrder == .descending {
            resorts.reverse()
        }
    }
}

enum CustomSortItem: String, CaseIterable {
    case defaultSort = "Default"
    case name = "Name"
    case country = "Country Name"
}

enum CustomSortOrder {
    case ascending
    case descending
}

#Preview {
    ContentView()
}

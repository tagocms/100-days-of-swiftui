//
//  ContentView.swift
//  iCanIdentify
//
//  Created by Tiago Camargo Maciel dos Santos on 15/07/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Person.name) private var people: [Person]
    
    @State private var isShowingAddView = false
    
    var body: some View {
        NavigationStack {
            Group {
                if people.isEmpty {
                    Button {
                        isShowingAddView.toggle()
                    } label: {
                        ContentUnavailableView {
                            Label("No people found", systemImage: "person.slash")
                        } description: {
                            Text("No people have been added yet.")
                        } actions: {
                            Text("Tap to add a person.")
                        }
                    }
                    .buttonStyle(.plain)
                } else {
                    List {
                        ForEach(people) { person in
                            NavigationLink(value: person) {
                                HStack {
                                    if let photoUIImage = person.convertDataToImage() {
                                        Image(uiImage: photoUIImage)
                                            .resizable()
                                            .scaledToFit()
                                    }
                                    VStack(alignment: .leading) {
                                        Text(person.name)
                                            .font(.headline)
                                        Text(person.summary)
                                            .font(.subheadline)
                                    }
                                    
                                    Spacer()
                                }
                                .frame(height: 100)
                            }
                        }
                        .onDelete(perform: deleteItem)
                    }
                }
            }
            .sheet(isPresented: $isShowingAddView) {
                AddPersonView()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingAddView.toggle()
                    } label: {
                        HStack {
                            Text("Add Person")
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .navigationTitle("iCanIdentify")
            .navigationDestination(for: Person.self) { person in
                DetailsView(person: person)
            }
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(people[offset])
        }
        do {
            try modelContext.save()
        } catch {
            
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Person.self)
}

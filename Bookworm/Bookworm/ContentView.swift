//
//  ContentView.swift
//  Bookworm
//
//  Created by Tiago Camargo Maciel dos Santos on 11/06/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(
        sort: [
            SortDescriptor(\BookModel.title, order: .forward),
            SortDescriptor(\BookModel.author, order: .forward)
        ]
    ) var books: [BookModel]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline.bold())
                                    .foregroundStyle(book.rating == 1 ? .red : .primary)
                                
                                Text(book.author)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBook)
            }
            .navigationDestination(for: BookModel.self) { book in
                DetailView(book: book)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBook(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(books[offset])
        }
    }
}

#Preview {
    ContentView()
}

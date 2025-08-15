//
//  AddBookView.swift
//  Bookworm
//
//  Created by Tiago Camargo Maciel dos Santos on 12/06/25.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3
    
    @State private var showErrorAlert = false
    private var isValidInput: Bool {
        if (
            title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            genre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            review.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            BookModel.genres.contains(where: { $0.lowercased() == genre.lowercased() }) == false ||
            (rating < 1 || rating > 5)
        ) {
            false
        } else {
            true
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(BookModel.genres, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        addNewBook()
                    }
                }
            }
            .navigationTitle("Add View")
            .alert("Error", isPresented: $showErrorAlert) {
                Button("OK") { }
            } message: {
                Text("All fields are required.")
            }
        }
        
    }
    
    func addNewBook() {
        
        
        guard isValidInput else {
            showErrorAlert = true
            return
        }
        
        let newBook = BookModel(title: title, author: author, genre: genre, review: review, rating: rating)
        
        modelContext.insert(newBook)
        dismiss()
    }
}

#Preview {
    AddBookView()
}

//
//  AddBookView.swift
//  Bookworm
//
//  Created by Gunther Masi Haas on 04/07/2024.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 0
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    @State private var showingAlertEmpty = false

    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }

                Section {
                    Button("Save") {
                        if (title.isEmpty || author.isEmpty) {
                            showingAlertEmpty = true;
                        } else {
                            let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: Date.now)
                        modelContext.insert(newBook)
                        dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert("Error adding book", isPresented: $showingAlertEmpty) {
                Button("OK") { }
            } message: {
                Text("Please enter book's title and/or author's name")
            }
        }
    }
}

#Preview {
    AddBookView()
}

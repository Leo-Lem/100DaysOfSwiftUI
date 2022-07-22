//
//  AddBookView.swift
//  Bookworm
//
//  Created by Leopold Lemmermann on 31.10.21.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var isPresented: Bool
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Unknown Genre"
    @State private var review = ""
    
    static let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(AddBookView.genres, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.menu)
                }

                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }

                Section {
                    Button("Save") {
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review
                        newBook.date = Date()
                        
                        try? self.moc.save()
                        
                        self.isPresented = false
                    }
                }
            }.navigationBarTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView(isPresented: .constant(true)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

//
//  ContentView.swift
//  ShoppingList
//
//  Created by Henry Buschmann on 15.06.22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var finishedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                }
                
                Section(header: Text("not done")) {
                    ForEach(usedWords, id: \.self) { word in
                        Text(word)
                    }
                    .onDelete(perform: { indexSet in
                        usedWords.remove(atOffsets: indexSet)
                    })
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
        }
    }
    
    func addNewWord() {
        let answer = newWord.trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {return}
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

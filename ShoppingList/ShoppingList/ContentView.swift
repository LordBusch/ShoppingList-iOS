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
    @State private var number = 0
    
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
                    .onDelete(perform: delete)
                }
                
                Section(header: Text("done")) {
                    ForEach(finishedWords, id: \.self) { word in
                        Text(word)
                    }
                    .onDelete(perform: { indexSet in
                        finishedWords.remove(atOffsets: indexSet)
                    })
                    
                }
                .listRowBackground(Color.init(red: 153 / 255, green: 255 / 255, blue: 204 / 255))
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
    
    func delete(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]
        finishedWords.insert(usedWords[index], at: 0)
        usedWords.remove(at: index)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

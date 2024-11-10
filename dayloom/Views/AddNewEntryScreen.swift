//
//  AddNewEntryScreen.swift
//  dayloom
//
//  Created by Melody Yu on 11/10/24.
//

import SwiftUI

struct AddNewEntryScreen: View {
    func saveEntry() {
        print("entry saved: \(entryText)")
        entryText=""
    }
    
    @State private var entryText: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text("Add New Entry")
                .font(.title)
                .bold()
                .padding(.bottom, 20)
            
            // Instruction Text
            Text("What are you grateful for?")
                .font(.headline)
            
            // TextEditor for User Input
            TextEditor(text: $entryText)
                .frame(height: 150)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            // Save Button
            Button(action: {
                saveEntry()
            }) {
                Text("Save Entry")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            Spacer() // Pushes content to the top
        }
        .padding()
        .navigationTitle("Add New Entry")
    }
}

#Preview {
    AddNewEntryScreen()
}

import SwiftUI

struct AddNewEntryScreen: View {
    @EnvironmentObject var viewModel: EntriesViewModel
    @State private var entryText: String = ""
    
    func saveEntry() {
        viewModel.addEntry(entryText)
        entryText = ""
        UIApplication.shared.endEditing()  // Dismiss the keyboard
    }
    
    var body: some View {
        ZStack {
            // Background color using your theme
            Color("EarthyBackground")
                .edgesIgnoringSafeArea(.all)  // Extend background to the whole screen
                .onTapGesture {
                    UIApplication.shared.endEditing()  // Dismiss the keyboard on tap
                }
            
            VStack(alignment: .leading, spacing: 20) {
                // Title
                Text("Add New Entry")
                    .font(.system(size: 24, weight: .bold, design: .serif))
                    .foregroundColor(Color("EarthyTitleColor"))
                
                Divider()
                    .background(Color("EarthyTitleColor").opacity(0.5))  // Subtle divider color
                
                // Instruction Text
                Text("What are you grateful for?")
                    .font(.system(size: 18, weight: .medium, design: .serif))
                    .foregroundColor(Color("EarthyTitleColor").opacity(0.7))
                
                // TextEditor for User Input
                TextEditor(text: $entryText)
                    .frame(height: 150)
                    .padding()
                    .background(Color("EarthyCardBackground"))
                    .cornerRadius(10)
                    .foregroundColor(Color("EarthyTitleColor"))
                
                // Save Button
                ActionButton(title: "Save Entry", action: saveEntry, backgroundColor: Color("EarthyBackground"), foregroundColor: Color("EarthyAccentColor"))
                
                Spacer()
            }
            .padding()
        }
    }
}

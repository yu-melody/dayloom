import SwiftUI

struct EditEntryScreen: View {
    @EnvironmentObject var viewModel: EntriesViewModel
    @Binding var entry: GratitudeEntryModel  // Directly bind to the entry being edited
    @Environment(\.presentationMode) var presentationMode  // Used for dismissing the sheet
    
    var body: some View {
        VStack {
            Text("Edit Entry")
                .font(.title)
                .bold()
                .padding(.bottom, 20)
            
            // Use a temporary binding with nil-coalescing for safe unwrapping
            TextEditor(text: $entry.text)
                .frame(height: 150)
                .padding()
                .background(Color("EarthyCardBackground"))
                .cornerRadius(10)
            
            ActionButton(title: "Save Changes", action: saveChanges, backgroundColor: Color("EarthyAccentColor"), foregroundColor: .white)
                .padding(.top, 20)
            
            ActionButton(title: "Delete Entry", action: deleteEntry, backgroundColor: Color("EarthyBackground").opacity(0.2), foregroundColor: .red)
            
        }
        .padding()
        .background(Color("EarthyBackground").edgesIgnoringSafeArea(.all))
    }
    
    private func saveChanges() {
        viewModel.updateEntry(id: entry.id, text: entry.text)  // Update the entry directly in the view model
        presentationMode.wrappedValue.dismiss()
    }
    
    private func deleteEntry() {
        viewModel.deleteEntry(id: entry.id)
        presentationMode.wrappedValue.dismiss()
    }
}

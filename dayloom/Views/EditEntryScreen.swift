import SwiftUI

struct EditEntryScreen: View {
    @EnvironmentObject var viewModel: EntriesViewModel
    @Binding var entry: GratitudeEntry  // Directly bind to the entry being edited
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

            Button(action: saveChanges) {
                Text("Save Changes")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("EarthyAccentColor"))
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            Button(action: deleteEntry) {
                            Text("Delete Entry")
                                .font(.headline)
                                .foregroundColor(.red)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("EarthyBackground").opacity(0.2))
                                .cornerRadius(10)
                        }
            
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

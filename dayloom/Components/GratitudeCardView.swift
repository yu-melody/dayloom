import SwiftUI

struct GratitudeCardView: View {
    @State private var isEditing = false  // Local state to control sheet presentation
    @Binding var entry: GratitudeEntryModel  // Binding to the gratitude entry for in-place editing

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Display date with muted color
            Text(entry.date, style: .date)
                .font(.system(size: 14, weight: .medium, design: .serif))
                .foregroundColor(Color("EarthyTitleColor").opacity(0.7))  // Softer text color
            
            // Display entry text with main body color and slight padding
            Text(entry.text)
                .font(.system(size: 16, weight: .regular, design: .serif))
                .foregroundColor(Color("EarthyTitleColor"))
                .padding(.vertical, 4)
            
            // Edit button aligned to the right
            HStack {
                Spacer()
                Button(action: {
                    isEditing = true  // Trigger the edit sheet
                }) {
                    Text("Edit")
                        .font(.footnote)
                        .foregroundColor(Color("EarthyAccentColor"))  // Accent color for the button
                        .padding(6)
                        .background(Color("EarthyBackground").opacity(0.2))  // Slight background color
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color("EarthyCardBackground"))  // Custom background color for the card
        .cornerRadius(12)  // Rounded corners for a softer look
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)  // Subtle shadow
        .sheet(isPresented: $isEditing) {
            EditEntryScreen(entry: $entry)  // Pass the binding for in-place editing
        }
    }
}

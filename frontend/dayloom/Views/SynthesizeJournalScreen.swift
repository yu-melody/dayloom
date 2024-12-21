import SwiftUI

struct SynthesizeJournalScreen: View {
    let entries: [GratitudeEntryModel]
    
    // Concatenate all entries into a single block of text
    private var concatenatedEntries: String {
        entries.map { $0.text }.joined(separator: "\n\n")
    }
    
    var body: some View {
        ZStack {
            // Background color for the entire screen
            Color("EarthyBackground")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Title with custom theme color and font
                    Text("Synthesize Journal")
                        .font(.system(size: 28, weight: .bold, design: .serif))
                        .foregroundColor(Color("EarthyTitleColor"))
                    
                    Divider()
                        .background(Color("EarthyTitleColor").opacity(0.5))  // Subtle divider color
                    
                    Text(concatenatedEntries)
                        .font(.body)
                        .foregroundColor(Color("EarthyTitleColor").opacity(0.9))
                        .background(Color("EarthyCardBackground"))
                        .cornerRadius(5)
                }
            }
            .padding()
        }
    }
}

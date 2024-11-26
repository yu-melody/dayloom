import SwiftUI

struct GratitudeScreen: View {
    @EnvironmentObject var viewModel: EntriesViewModel
    @State private var showAllEntries = false  // Controls navigation to all entries
    @State private var selectedEntry: GratitudeEntry? = nil
    @State private var refreshTrigger = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title
            Text("Gratitude Journal")
                .font(.system(size: 34, weight: .bold, design: .serif))
                .foregroundColor(Color("EarthyTitleColor"))
                .padding([.top, .leading])
            
            
            Divider()
                .background(Color("EarthyTitleColor").opacity(0.5))  // Subtle divider color
            
            // Check if there are entries to display
            if viewModel.entries.isEmpty {
                Text("No entries yet. Start by adding something you’re grateful for!")
                    .font(.body)
                    .foregroundColor(Color("EarthyTitleColor").opacity(0.7))
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            } else {
                // Display a limited number of entries with calming background colors
                ForEach(viewModel.entries.indices.prefix(3), id: \.self) { index in
                    GratitudeCardView(entry: $viewModel.entries[index])  // Pass binding using index
                        .padding(.horizontal)
                }

                
                // "View All Entries" Button
                NavigationLink(destination: ViewPastEntriesScreen()) {
                    Text("View All Entries")
                        .font(.headline)
                        .foregroundColor(Color("EarthyAccentColor"))
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                }
            }
            
            Spacer()
            
            // "Synthesize Journal" Button
            NavigationLink(destination: SynthesizeJournalScreen(entries: viewModel.entries)) {
                Text("Synthesize Journal")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("EarthyAccentColor"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            // Add New Entry button with softer tones and rounded edges
            NavigationLink(destination: AddNewEntryScreen()) {
                Text("Add New Entry")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("EarthyAccentColor"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .background(Color("EarthyBackground").edgesIgnoringSafeArea(.all))  // Earthy background color
    }
}

import SwiftUI

struct GratitudeScreen: View {
    @EnvironmentObject var viewModel: EntriesViewModel
    @State private var showAllEntries = false  // Controls navigation to all entries
    @State private var selectedEntry: GratitudeEntryModel? = nil
    @State private var refreshTrigger = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title
            TitleText(text: "Gratitude Journal")
            
            
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
                NavigationButton(title: "View All Entries", destination: AnyView(ViewPastEntriesScreen()))
            }
            
            Spacer()
            
            // "Synthesize Journal" Button
            NavigationButton(title: "Synthesize Journal", destination: AnyView(SynthesizeJournalScreen(entries: viewModel.entries)))
            .padding(.horizontal)
            
            // Add New Entry button with softer tones and rounded edges
            NavigationButton(title: "Add New Entry", destination: AnyView(AddNewEntryScreen()))
            .padding(.horizontal)
        }
        .background(Color("EarthyBackground").edgesIgnoringSafeArea(.all))  // Earthy background color
    }
}

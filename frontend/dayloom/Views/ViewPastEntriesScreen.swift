import SwiftUI

struct ViewPastEntriesScreen: View {
    @EnvironmentObject var viewModel: EntriesViewModel

    var body: some View {
        ZStack {
            // Background color for the entire screen
            Color("EarthyBackground")
                .edgesIgnoringSafeArea(.all)
            
            Divider()
                .background(Color("EarthyTitleColor").opacity(0.5))  // Subtle divider color

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Title with custom theme color and font
                    Text("All Entries")
                        .font(.system(size: 28, weight: .bold, design: .serif))
                        .foregroundColor(Color("EarthyTitleColor"))
                        .padding([.top, .leading])

                    // Display each entry using GratitudeCardView
                    ForEach(viewModel.entries.indices, id: \.self) { index in
                        GratitudeCardView(entry: $viewModel.entries[index])  // Pass binding to each entry
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.bottom) // Add padding at the bottom to prevent crowding
        }
    }
}

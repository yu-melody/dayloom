import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: EntriesViewModel  // Ensure this is EnvironmentObject

    var body: some View {
        NavigationView {
            VStack(spacing: 24) { // Add consistent spacing
                // Title
                Text("Welcome to dayloom")
                    .font(.system(size: 34, weight: .bold, design: .serif))
                    .foregroundColor(Color("EarthyTitleColor"))
                    .padding(.top, 32) // Add top padding for spacing
                
                Spacer()
                // Navigation Buttons
                NavigationLink(destination: GratitudeScreen()) {
                    Text("Gratitude Journal")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("EarthyAccentColor"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                NavigationLink(destination: DeviceScreen()) {
                    Text("Devices")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("EarthyAccentColor"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                NavigationLink(destination: RoutineScreen()) {
                    Text("Routines")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("EarthyAccentColor"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                Spacer() // Push content up
            }
            .padding(.bottom) // Add bottom padding for better spacing
            .background(Color("EarthyBackground").edgesIgnoringSafeArea(.all)) // Themed background
        }
    }
}

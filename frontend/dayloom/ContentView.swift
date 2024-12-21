import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 24) { // Add consistent spacing
                // Title
                TitleText(text: "Welcome to dayloom")
                
                Image("dayloom-transparent")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150) // Adjust size as needed
                                    .padding(.top, 40) // Add padding to the top
                
                // Navigation Buttons
                NavigationButton(title: "Gratitude Journal", destination: AnyView(GratitudeScreen()))
                NavigationButton(title: "Devices", destination: AnyView(DeviceScreen()))
                NavigationButton(title: "Routines", destination: AnyView(RoutineScreen()))
                Spacer() // Push content up
            }
            .padding(.bottom) // Add bottom padding for better spacing
            .background(Color("EarthyBackground").edgesIgnoringSafeArea(.all)) // Themed background
        }
    }
}

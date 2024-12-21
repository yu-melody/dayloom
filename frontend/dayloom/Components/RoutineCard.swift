//
//  SwiftUIView.swift
//  dayloom
//
//  Created by Melody Yu on 11/25/24.
//

import SwiftUI

struct RoutineCard: View {
    @ObservedObject var routineViewModel: RoutineViewModel

    var body: some View {
        NavigationLink(destination: RoutineDetailScreen(routineViewModel: routineViewModel)) {
            VStack(alignment: .leading, spacing: 16) {
                // Title and Toggle
                HStack {
                    Text(routineViewModel.name)
                        .font(.system(size: 20, weight: .semibold, design: .serif))
                        .foregroundColor(Color("EarthyTitleColor"))
                    
                    Spacer()
                    
                    Toggle("", isOn: $routineViewModel.isEnabled)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: Color("EarthyAccentColor"))) // Styled toggle
                    
                    Image(systemName: "chevron.right")
                                            .foregroundColor(Color("EarthyAccentColor")) // Chevron for navigation
                }
                
                // Time Picker
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(Color("EarthyAccentColor"))
                        .font(.system(size: 16))
                    
                    DatePicker("", selection: $routineViewModel.time, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .accentColor(Color("EarthyAccentColor"))
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .cornerRadius(8)
                
                // Subtle text for "Tap to edit"
                Text("Tap to edit routine")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .padding(.top, 4)
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("EarthyCardBackground"), Color("EarthyCardBackground").opacity(0.7)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
            )
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
    }
}

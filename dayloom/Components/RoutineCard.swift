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

struct RoutineCard_Previews: PreviewProvider {
    static var previews: some View {
        RoutineCard(
            routineViewModel: RoutineViewModel(routine: RoutineModel(name: "Morning Routine"))
        )
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color("EarthyBackground"))
    }
}

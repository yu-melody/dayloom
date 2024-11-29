//
//  RoutineDetailScreen.swift
//  dayloom
//
//  Created by Melody Yu on 11/29/24.
//


import SwiftUI

struct RoutineDetailScreen: View {
    @ObservedObject var routineViewModel: RoutineViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title
            TitleText(text: "Edit \(routineViewModel.name)")

            Divider()
                .background(Color("EarthyTitleColor").opacity(0.5)) // Subtle divider color
            
            // Action Toggles
            ForEach(routineViewModel.actions.indices, id: \.self) { index in
                HStack {
                    Text(routineViewModel.actions[index].type.rawValue.capitalized)
                        .font(.system(size: 18, weight: .medium, design: .serif))
                        .foregroundColor(Color("EarthyTitleColor"))

                    Spacer()

                    Toggle("", isOn: $routineViewModel.actions[index].isEnabled)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: Color("EarthyAccentColor")))
                }
                .padding()
                .background(Color("EarthyCardBackground"))
                .cornerRadius(10)
            }

            Spacer()
        }
        .background(Color("EarthyBackground").edgesIgnoringSafeArea(.all))
    }
}

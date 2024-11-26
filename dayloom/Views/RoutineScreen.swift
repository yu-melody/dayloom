//
//  RoutineScreen.swift
//  dayloom
//
//  Created by Melody Yu on 11/9/24.
//

import SwiftUI

struct RoutineScreen: View {
    @StateObject private var routineListViewModel = RoutineListViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title
            Text("Daily Routines")
                .font(.system(size: 34, weight: .bold, design: .serif))
                .foregroundColor(Color("EarthyTitleColor"))
                .padding([.top, .leading])

            Divider()
                .background(Color("EarthyTitleColor").opacity(0.5)) // Subtle divider color

            // Routine Cards
            ForEach(routineListViewModel.routines) { routine in
                RoutineCard(routineViewModel: routine)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .padding(.bottom) // Padding for the bottom area
        .background(Color("EarthyBackground").edgesIgnoringSafeArea(.all)) // Earthy background color
    }
}

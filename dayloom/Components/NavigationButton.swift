//
//  NavigationButton.swift
//  dayloom
//
//  Created by Melody Yu on 11/26/24.
//

import SwiftUI

struct NavigationButton: View {
    var title: String
    var destination: AnyView
    var backgroundColor: Color = Color("EarthyAccentColor")
    var foregroundColor: Color = .white

    var body: some View {
        NavigationLink(destination: destination) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

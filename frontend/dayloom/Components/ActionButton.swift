//
//  ActionButton.swift
//  dayloom
//
//  Created by Melody Yu on 11/26/24.
//

import SwiftUI

struct ActionButton: View {
    var title: String
    var action: () -> Void
    var backgroundColor: Color = Color("EarthyAccentColor")
    var foregroundColor: Color = .white
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(foregroundColor)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .cornerRadius(10)
        }
    }
}

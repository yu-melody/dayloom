//
//  TitleText.swift
//  dayloom
//
//  Created by Melody Yu on 11/26/24.
//


import SwiftUI

struct TitleText: View { // Ensure it conforms to View
    var text: String

    var body: some View { // Required body property
        Text(text)
            .font(.system(size: 34, weight: .bold, design: .serif))
            .foregroundColor(Color("EarthyTitleColor"))
            .padding(.top, 32)
            .padding(.leading, 16)
    }
}

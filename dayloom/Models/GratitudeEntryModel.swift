//
//  GratitudeEntry.swift
//  dayloom
//
//  Created by Melody Yu on 11/26/24.
//

import Foundation

struct GratitudeEntryModel: Identifiable, Codable {
    let id: UUID
    var text: String
    let date: Date
}

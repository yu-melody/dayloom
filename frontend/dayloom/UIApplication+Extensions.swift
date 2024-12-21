//
//  UIApplication+Extensions.swift
//  dayloom
//
//  Created by Melody Yu on 11/10/24.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


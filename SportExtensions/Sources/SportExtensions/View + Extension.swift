//
//  View + Extension.swift
//
//
//  Created by Vova Novosad on 11.05.2024.
//

import SwiftUI

public extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

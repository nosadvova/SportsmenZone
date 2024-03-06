//
//  NavigationIconModifier.swift
//
//
//  Created by Vova Novosad on 23.02.2024.
//

import SwiftUI

public struct NavigationIconModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundStyle(.green)
    }
}

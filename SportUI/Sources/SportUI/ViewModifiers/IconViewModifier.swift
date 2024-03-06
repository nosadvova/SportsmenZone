//
//  IconViewModifier.swift
//  
//
//  Created by Vova Novosad on 19.02.2024.
//

import SwiftUI

public struct IconViewModifier: ViewModifier {
    @Binding var isCorrect: Bool
    
    public init(isCorrect: Binding<Bool>) {
        self._isCorrect = isCorrect
    }
    public func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundStyle(isCorrect ? Color.lightGrayColor : .red)
    }
}

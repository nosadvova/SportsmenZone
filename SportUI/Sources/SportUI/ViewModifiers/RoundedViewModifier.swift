//
//  RoundedViewModifier.swift
//  
//
//  Created by Vova Novosad on 06.03.2024.
//

import SwiftUI

public struct RoundedViewModifier: ViewModifier {
    var color: Color
    
    public func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(color)
                    .frame(maxWidth: .infinity)
            )
    }
}

//#Preview {
//    RoundedViewModifier()
//}

//
//  LinkButtonStyle.swift
//  
//
//  Created by Vova Novosad on 27.02.2024.
//

import SwiftUI
import SportExtensions

public struct LinkButtonStyle: ViewModifier {
    let foregroundColor: Color
    let underlineWidth: CGFloat
    
    public init(foregroundColor: Color = .mustardColor, underlineWidth: CGFloat) {
        self.foregroundColor = foregroundColor
        self.underlineWidth = underlineWidth
    }
    
    public func body(content: Content) -> some View {
        VStack(spacing: 0) {
            content
                .foregroundStyle(foregroundColor)
                .font(.sport.system(.body))
            
            RoundedRectangle(cornerRadius: 8)
                .frame(width: underlineWidth, height: 0.7)
                .foregroundStyle(foregroundColor)
        }
    }
}

#Preview {
    Button {
        //
    } label: {
        Text("Click me")
    }
    .modifier(LinkButtonStyle(underlineWidth: 100))
}

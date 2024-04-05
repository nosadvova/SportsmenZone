//
//  RectangleButtonStyle.swift
//  
//
//  Created by Vova Novosad on 18.02.2024.
//

import SwiftUI

public struct RectangleButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    private var backgroundColor: Color
    private var foregroundStyle: Color
    
    public init(backgroundColor: Color, foregroundStyle: Color) {
        self.backgroundColor = backgroundColor
        self.foregroundStyle = foregroundStyle
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(5)
            .font(.sport.system(.button))
            .background(isEnabled ? backgroundColor : Color.inactiveButtonBackgroundColor)
            .foregroundStyle(foregroundStyle)
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.5)
            .clipShape(
                Rectangle()
            )
            .shadow(radius: 5)
        
            
    }
}

#Preview {
    Button {
        //
    } label: {
        Text("Text")
            .frame(width: 200)
    }
    .buttonStyle(RectangleButtonStyle(backgroundColor: .red, foregroundStyle: .white))
}

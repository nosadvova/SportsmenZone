//
//  RoundButtonStyle.swift
//
//
//  Created by Vova Novosad on 21.02.2024.
//

import SwiftUI
import SportExtensions

public struct RoundButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    let sideAlignment: RoundButtonAlignment
    let backgroundColor: Color
    let foregroundStyle: Color
    
    public init(sideAlignment: RoundButtonAlignment = .center, backgroundColor: Color, foregroundStyle: Color) {
        self.sideAlignment = sideAlignment
        self.backgroundColor = backgroundColor
        self.foregroundStyle = foregroundStyle
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.sport.system(.button))
            .background(isEnabled ? backgroundColor : Color.inactiveButtonBackgroundColor)
            .foregroundStyle(foregroundStyle)
            .multilineTextAlignment(.center)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            .minimumScaleFactor(0.5)
            .clipShape(
                sideAlignment.buttonShape
            )
    }
}


extension RoundButtonStyle {
    public enum RoundButtonAlignment {
        case center
        case left
        case right
                
        var buttonShape: some Shape {
            switch self {
            case .center:
                UnevenRoundedRectangle(cornerRadii: .init(topLeading: 30, bottomLeading: 30, bottomTrailing: 30, topTrailing: 30))
            case .left:
                UnevenRoundedRectangle(cornerRadii: .init(topLeading: 30 ,bottomLeading: 30))
            case .right:
                UnevenRoundedRectangle(cornerRadii: .init(bottomTrailing: 30, topTrailing: 30))
            }
        }
    }
}

#Preview {
    Button(action: {}) {
      Text("Log in")
        .frame(width: 200)
    }
    .buttonStyle(RoundButtonStyle(backgroundColor: .green, foregroundStyle: .white))
}

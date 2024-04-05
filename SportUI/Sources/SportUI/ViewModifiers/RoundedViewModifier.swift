//
//  RoundedViewModifier.swift
//  
//
//  Created by Vova Novosad on 06.03.2024.
//

import SwiftUI
import SportExtensions

public struct RoundedViewModifier: ViewModifier {
    var title: String?
    var color: Color
    var opacity: Double
    
    public init(title: String? = nil, color: Color, opacity: Double = 1.0) {
        self.title = title
        self.color = color
        self.opacity = opacity
    }
    
    public func body(content: Content) -> some View {
        VStack {
            if let title = title {
                HStack {
                    Text(title)
                        .font(.sport.system(.body))
                        .foregroundStyle(Color.lightGrayColor)
                    
                    Spacer()
                }
            }
            
            content.background(
                RoundedRectangle(cornerRadius: 15)
                    .shadow(radius: 1.5)
                    .opacity(opacity)
                    .foregroundStyle(color)
                    .frame(maxWidth: .infinity)
            )
        }
    }
}

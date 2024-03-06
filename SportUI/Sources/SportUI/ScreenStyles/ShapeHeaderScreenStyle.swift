//
//  ShapeHeaderScreenStyle.swift
//
//
//  Created by Vova Novosad on 06.03.2024.
//

import SwiftUI
import SportExtensions

public struct ShapeHeaderScreenStyle<Content>: View where Content: View {
    
    private let title: String
    private let description: String?
    private let headerColor: Color
    private let foregroundColor: Color
    private let content: () -> Content
    
    public init(
        title: String,
        description: String? = nil,
        color: Color = .oliveColor,
        foregroundColor: Color = .mainTextColor,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.description = description
        self.headerColor = color
        self.foregroundColor = foregroundColor
        self.content = content
    }
    
    public var body: some View {
        VStack {
            VStack {
                Text(title)
                    .font(.sport.system(.largeTitle))
                    .foregroundStyle(Color.mainTextColor)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                if let description {
                    Text(description)
                        .font(.sport.system(.description))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(foregroundColor)
                        .padding(.horizontal, 20)
                        .padding(.bottom)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(headerColor)
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea()
            )
            
            content()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .top
                )
                .padding()
        }
        .background(Color.backgroundColor)
    }
}

#Preview {
    ShapeHeaderScreenStyle(title: "Title", description: "Description of screen", color: .sunsetColor, content: {
        Text("Content")
    })
}

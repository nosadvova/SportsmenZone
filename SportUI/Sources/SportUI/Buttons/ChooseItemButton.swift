//
//  ChooseItemButton.swift
//
//
//  Created by Vova Novosad on 28.02.2024.
//

import SwiftUI
import SportExtensions

public struct ChooseItemButton: View {
    private let title: String
    private let description: String
    private let image: Image
    private let backgroundColor: Color
    let rectangleWidth: CGFloat
    let rectangleHeight: CGFloat
    
    var action: () -> ()
    
    @Binding var isSelected: Bool
    
    public init(title: String,
                description: String,
                image: Image,
                backgroundColor: Color = .mustardColor,
                rectangleWidth:CGFloat = 170,
                rectangleHeight: CGFloat = 170,
                isSelected: Binding<Bool>,
                action: @escaping () -> ()) {
        self.title = title
        self.description = description
        self.image = image
        self.backgroundColor = backgroundColor
        self.rectangleWidth = rectangleWidth
        self.rectangleHeight = rectangleHeight
        self._isSelected = isSelected
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            action()
        }, label: {
            VStack {
                Text(title)
                    .font(.sport.system(.title))
                    .foregroundStyle(Color.mainTextColor)
                
                Text(description)
                    .font(.sport.system(.description))
                    .foregroundStyle(Color.gray)
                
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: rectangleWidth / 2, height: rectangleHeight / 2)
            }
            .frame(alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(isSelected ? backgroundColor.gradient : Color.inactiveButtonBackgroundColor.gradient)
                    .frame(width: rectangleWidth, height: rectangleHeight)
                    .overlay(alignment: .topTrailing, content: {
                        if isSelected {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(Color.green)
                                .offset(x: 5, y: -5)
                        }
                    })
            )
        })
    }
}

#Preview {
    HStack(spacing: 65) {
        ChooseItemButton(title: "Person", description: "The view for person", image: Image(systemName: "person.fill"), isSelected: .constant(true), action: {
            //
        })
        ChooseItemButton(title: "Person", description: "The view for person", image: Image(systemName: "person.fill"), isSelected: .constant(false), action: {
            //
        })
    }
}

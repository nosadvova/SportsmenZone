//
//  PrimaryScreenStyle.swift
//
//
//  Created by Vova Novosad on 23.02.2024.
//

import SwiftUI
import SportExtensions

public struct PrimaryScreenStyle<Content>: View where Content: View {
    @Environment(\.dismiss) var dismiss
    
    private let title: String
    private let textAlignment: TextAlignment
    private let frameAlignment: Alignment
    private let description: String?
    private let dismissButton: NavigationIcon?
    private let content: () -> Content
    
    public init(
        title: String,
        textAlignment: TextAlignment = .leading,
        frameAlignment: Alignment = .leading,
        description: String? = nil,
        dismissButton: NavigationIcon? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.textAlignment = textAlignment
        self.frameAlignment = frameAlignment
        self.description = description
        self.dismissButton = dismissButton
        self.content = content
    }
    
    public var body: some View {
        VStack {
            if let dismissButton {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        switch dismissButton {
                        case .close:
                            Spacer()
                            dismissButton.image?
                                .resizable()
                                .frame(width: 18, height: 18)
                        case .back:
                            dismissButton.image?
                                .resizable()
                                .frame(width: 20, height: 16)
                            Spacer()
                        case .forward:
                            EmptyView()
                        }
                    }
                    .padding(10)
                    .foregroundStyle(Color.mustardColor)
                }
            }
            
            Text(title)
                .font(.sport.system(.largeTitle))
                .foregroundStyle(Color.mainTextColor)
                .multilineTextAlignment(textAlignment)
                .frame(maxWidth: .infinity, alignment: frameAlignment)
                .padding()
            
            if let description {
                Text(description)
                    .font(.sport.system(.description))
                    .multilineTextAlignment(textAlignment)
                    .frame(maxWidth: .infinity, alignment: frameAlignment)
                    .foregroundStyle(Color.lightGrayColor)
                    .padding(.horizontal, 20)
            }
            
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
    PrimaryScreenStyle(title: "Title long lik title", description: "Description of this screen to check how long text will fit in this fdjfhdjfd fdfhdjfhjdf dfhdjfhjdhfd fhdjhfjdhfjdhfd dhfjdhfjdhfj dfhdjfh", dismissButton: .back, content: {
        Text("Content")
    })
}

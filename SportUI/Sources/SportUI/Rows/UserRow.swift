//
//  UserRow.swift
//  
//
//  Created by Vova Novosad on 08.03.2024.
//

import SwiftUI
import SportExtensions
import Models

public struct UserRow<Content>: View where Content: View {
    @State var isExpanded: Bool = false
    var isInteractionAllowed: Bool
    var isSystemImage: Bool
    var userImage: String?
    var fullName: String
    var info: String
    var content: () -> Content
    
    public init(
        isInteractionAllowed: Bool,
        isSystemImage: Bool = false,
        userImage: String? = "bubble.left.fill",
        fullName: String,
        info: String,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.isInteractionAllowed = isInteractionAllowed
        self.isSystemImage = isSystemImage
        self.userImage = userImage
        self.fullName = fullName
        self.info = info
        self.content = content
    }
    
    public var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    if isSystemImage {
                        Image(systemName: userImage!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.horizontal, 10)
                    } else {
                        Image(userImage ?? "placeholder-image")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    
                    
                    VStack(alignment: .leading) {
                        Text(fullName)
                            .font(.sport.system(.body))
                            .foregroundStyle(Color.mainTextColor)
                        
                        Text(info)
                            .font(.sport.system(.description))
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    withAnimation(.bouncy) {
                        if isInteractionAllowed {
                            isExpanded.toggle()
                        }
                    }
                }
                if isExpanded {
                    content()
                        .padding(.leading, 20)
                        .transition(.opacity)
                }
                
            }
            .background(
                isInteractionAllowed ?
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white) : nil
            )
        }
}

#Preview {
    VStack {
        UserRow(isInteractionAllowed: true, fullName: "Akira Kurosava", info: "Greatest filmaker", content: {
            Divider()
            Text("Hey")
        })
    }
    .frame(height: 250)
    .background(Color.backgroundColor)
}

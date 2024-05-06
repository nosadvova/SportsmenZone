//
//  ExpandableView.swift
//
//
//  Created by Vova Novosad on 03.05.2024.
//

import SwiftUI

public struct ExpandableView<Content>: View where Content: View {
    @State var isExpanded = false
    let title: String
    let image: Image
    let content: () -> Content
    
    public init(title: String, image: Image, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.image = image
        self.content = content
    }
    
    public var body: some View {
        VStack {
            if !isExpanded {
                HStack {
                    Text(title)
                        .font(.sport.system(.button))
                    Spacer()
                    image
                        .imageScale(.large)
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                        .animation(.easeInOut(duration: 0.2), value: isExpanded)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundStyle(.black)
                .cornerRadius(10)
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
            } else {
                VStack {
                    content()
                }
                .frame(maxWidth: .infinity)
                .transition(.opacity)
            }
        }
    }
}


#Preview {
    ExpandableView(title: "Press me", image: Image(systemName: "plus.circle.fill")) {
        Text("Hey")
        Text("Hey")
        Text("Hey")
        Text("Hey")
    }
}

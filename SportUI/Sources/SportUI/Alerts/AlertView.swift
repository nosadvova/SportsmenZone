//
//  AlertView.swift
//  
//
//  Created by Vova Novosad on 06.03.2024.
//

import SwiftUI
import SportExtensions

public struct AlertView<Content>: View where Content: View {
    @Binding var isActive: Bool
    let title: String
    let message: String?
    let buttonTitle: String
    var content: () -> Content
    @State private var offset: CGFloat = 1000
    
    public init(
        isActive: Binding<Bool>,
        title: String,
        message: String? = nil,
        buttonTitle: String = "Dismiss",
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isActive = isActive
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            if isActive {
                Color.black
                    .opacity(isActive ? 0.2 : 0)
                    .onTapGesture {
                        close()
                    }
                
                VStack {
                    Text(title)
                        .font(.title)
                        .foregroundStyle(Color.mainTextColor)
                        .multilineTextAlignment(.center)
                        .frame(alignment: .center)
                    
                    if let message = message {
                        Text(message)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                            .font(.headline)
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                            .frame(alignment: .center)
                    }
                    
                    content()
                                        
                    Button(action: {
                        close()
                    }, label: {
                        Text(buttonTitle)
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(RoundButtonStyle(backgroundColor: .oliveColor, foregroundStyle: .white))
                }
                .padding(24)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 20)
                .padding(24)
                .offset(x: 0, y: offset)
                .onAppear {
                  withAnimation(.spring()) {
                    offset = 0
                  }
                }
            }
        }
        .ignoresSafeArea()
    }
    
    private func close() {
        withAnimation(.smooth) {
            offset = 1000
            isActive = false
        }
    }
}

#Preview {
    AlertView(isActive: .constant(true), title: "Title", message: "Description for alert", content: {
        Text("SS")
    })
}

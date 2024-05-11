//
//  SliderView.swift
//  
//
//  Created by Vova Novosad on 10.05.2024.
//

import SwiftUI

public struct SliderView<Content>: View where Content: View {
    @Binding var showModal: Bool
    private let content: () -> Content
    
    public init(
        showModal: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._showModal = showModal
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            if showModal {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showModal = false
                        }
                    }
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                showModal = false
                            }
                        }) {
                            Image(systemName: "xmark")
                                .frame(width: 15, height: 15)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 20))
                        }
                    }
                    
                    content()
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .shadow(radius: 20)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .transition(.move(edge: .bottom))
                .zIndex(1)
            }
        }
        .animation(.spring, value: showModal)
    }
}

#Preview {
    SliderView(showModal: .constant(true)) {
        Text("Indide")
    }

}

//
//  PopupMessageViewModifier.swift
//
//
//  Created by Vova Novosad on 18.03.2024.
//

import SwiftUI

public enum PopupMessageType {
    case success, failure
    
    var image: Image {
        switch self {
        case .success:
            Image(systemName: "checkmark.circle.fill")
        case .failure:
            Image(systemName: "multiply.circle.fill")
        }
    }
}

public struct PopupMessageViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    let type: PopupMessageType
    let message: String
    
    public init(isPresented: Binding<Bool>, type: PopupMessageType, message: String) {
        self._isPresented = isPresented
        self.type = type
        self.message = message
    }
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content

            if isPresented {
                HStack {
                    type.image
                        .padding(.trailing)
                        .foregroundStyle(type == .failure ? .red : .green)
                        .font(.system(size: 25))
                    
                    Text(message)
                        .font(.sport.system(.body))
                }
                .padding()
                .frame(maxWidth: .infinity)
                .modifier(RoundedViewModifier(color: .white))
                .padding([.horizontal, .top])
                .zIndex(1)
                .animation(.spring().delay(0.2), value: isPresented)
                .onAppear {
                    withAnimation { isPresented = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation { isPresented = false }
                    }
                }
                .onTapGesture {
                    withAnimation { isPresented = false }
                }
                .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
            }
        }
        .animation(.spring, value: isPresented)
    }
}

#Preview {
    VStack {
        Text("Hey")
            .modifier(PopupMessageViewModifier(isPresented: .constant(true), type: .success, message: "Your operation was successfull!"))
    }
}

//
//  PopupMessageView.swift
//
//
//  Created by Vova Novosad on 17.03.2024.
//

import SwiftUI

public struct PopupMessageView: View {
    
    @Binding var isPresented: Bool
    let type: PopupMessageType
    let message: String
    
    public init(isPresented: Binding<Bool>, type: PopupMessageType, message: String) {
        self._isPresented = isPresented
        self.type = type
        self.message = message
    }
    
    public var body: some View {
        
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
            .padding(.horizontal)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    withAnimation { isPresented = false }
                }
            }
            .onTapGesture {
                withAnimation { isPresented = false }
            }
            .animation(.spring().delay(0.2), value: isPresented)
            .transition(.asymmetric(
                insertion: .move(edge: .top),
                removal: .move(edge: .top)
            ))
        }
    }
}




#Preview {
    VStack {
        PopupMessageView(isPresented: .constant(true), type: .success, message: "Your operation was successfull!")
    }
}

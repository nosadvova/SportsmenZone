//
//  LoadingViewModifier.swift
//  
//
//  Created by Vova Novosad on 08.05.2024.
//

import SwiftUI

public struct LoadingViewModifier: ViewModifier {
    @Binding var isLoading: Bool
    var opacity: Double
    
    public init(isLoading: Binding<Bool>, opacity: Double = 0.1) {
        self._isLoading = isLoading
        self.opacity = opacity
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? 3 : 0)
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .inactiveButtonBackgroundColor))
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(opacity).edgesIgnoringSafeArea(.all))
            }
        }
    }
}

#Preview {
    Text("HHHH")
        .modifier(LoadingViewModifier(isLoading: .constant(true)))
}

//
//  OtpModifer.swift
//
//
//  Created by Vova Novosad on 26.02.2024.
//

import SwiftUI
import Combine

public struct OtpModifer: ViewModifier {
    
    @Binding var pin: String
    
    var textLimt = 1
    
    public init(pin: Binding<String>, textLimt: Int = 1) {
        self._pin = pin
        self.textLimt = textLimt
    }
    
    func limitText(_ upper: Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }
    
    public func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText(textLimt)}
            .frame(width: 45, height: 45)
            .background(Color.white.cornerRadius(5))
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.mustardColor, lineWidth: 2)
            )
    }
}

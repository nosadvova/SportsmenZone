//
//  DefaultTextField.swift
//  
//
//  Created by Vova Novosad on 08.05.2024.
//

import SwiftUI

public struct DefaultTextField: View {
    @Binding var text: String
    private let placeholder: String
    private let foregroundStyle: Color
    
    public init(text: Binding<String>, placeholder: String, foregroundStyle: Color = .black) {
        self._text = text
        self.placeholder = placeholder
        self.foregroundStyle = foregroundStyle
    }
    public var body: some View {
        TextField(placeholder, text: $text, axis: .vertical)
            .frame(maxWidth: .infinity, alignment: .leading)
            .keyboardType(.asciiCapable)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .font(.sport.system(.textField))
            .multilineTextAlignment(.leading)
            .foregroundStyle(foregroundStyle)
    }
}

#Preview {
    DefaultTextField(text: .constant("sd"), placeholder: "Text field")
}

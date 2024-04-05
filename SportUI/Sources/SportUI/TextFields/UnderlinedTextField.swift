//
//  UnderlinedTextField.swift
//  
//
//  Created by Vova Novosad on 19.02.2024.
//

import SwiftUI
import SportExtensions

public struct UnderlinedTextField: View {
    
    let placeholder: String
    
    @Binding var text: String
    @Binding var isCorrect: Bool
    private let icon: String?
    
    private let defaultBorderColor: Color
    private let defaultForegroundStyle: Color
    
    private let isSecuredTextField: Bool
    @State private var isContentSecured: Bool = true
    @FocusState private var isTextFieldFocused: Bool
    
    public init(
        placeholder: String,
        text: Binding<String>,
        isCorrect: Binding<Bool> = .constant(true),
        icon: String? = nil,
        defaultBorderColor: Color = .inactiveButtonBackgroundColor,
        defaultForegroundStyle: Color = .mainTextColor,
        isSecuredTextField: Bool = false
    ) {
        self.placeholder = placeholder
        self._text = text
        self._isCorrect = isCorrect
        self.icon = icon
        self.defaultBorderColor = defaultBorderColor
        self.defaultForegroundStyle = defaultForegroundStyle
        self.isSecuredTextField = isSecuredTextField
    }
    
    public var body: some View {
        VStack {
            
            HStack {
                Text(placeholder)
                    .font(.sport.system(.caption))
                    .foregroundStyle(foregroundColor)
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom),
                        removal: .move(edge: .top)
                    ))
                    .animation(.easeOut, value: isTextFieldFocused)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .opacity(isTextFieldFocused || !text.isEmpty ? 1 : 0)
                    .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 0))
            }
            
            HStack {
                secureTextField
                    .focused($isTextFieldFocused)
                
                if !text.isEmpty {
                    if isSecuredTextField {
                        self.securedTextFieldButton
                    } else {
                        self.regularTextFieldButton
                    }
                }
            }
            .padding(.horizontal, 20)
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 1)
                .foregroundStyle(foregroundColor)
                .padding(.horizontal)
            
        }
    }
    
    private var secureTextField: some View {
        ZStack {
            TextField(placeholder, text: $text)
                .opacity(isSecuredTextField ? 0 : 1)
            
            if isContentSecured {
                SecureField(placeholder, text: $text)
                    .opacity(isSecuredTextField ? 1 : 0)
            } else {
                TextField(placeholder, text: $text)
                    .opacity(isSecuredTextField ? 1 : 0)
            }
        }
        .keyboardType(.asciiCapable)
        .autocorrectionDisabled(isSecuredTextField)
        .textInputAutocapitalization(.never)
        .font(.sport.system(.textField))
        .multilineTextAlignment(.leading)
        .foregroundColor(foregroundColor)
    }
}


extension UnderlinedTextField {
    private var foregroundColor: Color {
        !isCorrect ? .red : .mainTextColor
    }
}

extension UnderlinedTextField {
    private var securedTextFieldButton: some View {
        Button(action: {
            isContentSecured.toggle()
        }, label: {
            Image(systemName: isContentSecured ? "eye.fill" : "eye.slash.fill")
        })
        .modifier(IconViewModifier(isCorrect: $isCorrect))
    }
    
    private var regularTextFieldButton: some View {
        Button(action: {
            text = ""
        }, label: {
            if let icon {
                Image(systemName: icon)
            } else {
                Image(systemName: "multiply.circle.fill")
            }
        })
        .modifier(IconViewModifier(isCorrect: $isCorrect))
    }
}


#Preview {
    VStack {
        UnderlinedTextField(placeholder: "Email", text: .constant("dfd"), isCorrect: .constant(true), icon: "person.crop.circle.fill", isSecuredTextField: false)
        UnderlinedTextField(placeholder: "Email", text: .constant("dfd"), isCorrect: .constant(true), isSecuredTextField: false)
        UnderlinedTextField(placeholder: "Password", text: .constant("dfd"), isCorrect: .constant(true), isSecuredTextField: true)
    }
}

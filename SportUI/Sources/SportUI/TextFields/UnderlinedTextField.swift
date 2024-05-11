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
    let headerDisabled: Bool
    let underlineDisabled: Bool
    
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
        headerDisabled: Bool = false,
        underlineDisabled: Bool = false,
        defaultBorderColor: Color = .mainTextColor,
        defaultForegroundStyle: Color = .mainTextColor,
        isSecuredTextField: Bool = false
    ) {
        self.placeholder = placeholder
        self._text = text
        self._isCorrect = isCorrect
        self.icon = icon
        self.headerDisabled = headerDisabled
        self.underlineDisabled = underlineDisabled
        self.defaultBorderColor = defaultBorderColor
        self.defaultForegroundStyle = defaultForegroundStyle
        self.isSecuredTextField = isSecuredTextField
    }
    
    public var body: some View {
        VStack {
            if !headerDisabled {
                    Text(placeholder)
                        .font(.sport.system(.caption))
                        .foregroundStyle(foregroundColor)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .animation(.easeOut, value: isTextFieldFocused)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(isTextFieldFocused || !text.isEmpty ? 1 : 0)
                        .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 0))
            }
            
            HStack {
                secureTextField
                    .font(.sport.system(.textField))
                    .focused($isTextFieldFocused)
                
                if !text.isEmpty && isTextFieldFocused {
                    if isSecuredTextField {
                        self.securedTextFieldButton
                    } else {
                        self.regularTextFieldButton
                    }
                }
            }
            .padding(.horizontal, 20)
            
            if !underlineDisabled {
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 1)
                    .foregroundStyle(defaultBorderColor)
                    .padding(.horizontal)
            }
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
            isTextFieldFocused = true
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
        UnderlinedTextField(placeholder: "Email", text: .constant("tytyt"), isCorrect: .constant(true), icon: "person.crop.circle.fill", headerDisabled: false, isSecuredTextField: false)
        UnderlinedTextField(placeholder: "Email", text: .constant("dfd"), isCorrect: .constant(true), isSecuredTextField: false)
        UnderlinedTextField(placeholder: "Password", text: .constant("dfd"), isCorrect: .constant(true), isSecuredTextField: true)
    }
}

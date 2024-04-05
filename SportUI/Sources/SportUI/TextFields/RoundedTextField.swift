//
//  RoundedTextField.swift
//  
//
//  Created by Vova Novosad on 14.03.2024.
//

import SwiftUI

public struct RoundedTextField: View {
    
    @Binding var text: String
    @Binding var isCorrect: Bool
    
    private let placeholder: String
    private let isEditing: Bool
    
    public init(text: Binding<String>, isCorrect: Binding<Bool> = .constant(true), placeholder: String, isEditing: Bool = true) {
        self._text = text
        self._isCorrect = isCorrect
        self.placeholder = placeholder
        self.isEditing = isEditing
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
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .opacity(!text.isEmpty ? 1 : 0)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
            }
            
            HStack {
                TextField(placeholder, text: $text, axis: .vertical)
                    .padding(EdgeInsets(top: 1, leading: 15, bottom: 1, trailing: 15))
                    .keyboardType(.asciiCapable)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .font(.sport.system(.textField))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(foregroundColor)
                    .disabled(!isEditing)
                
                if isEditing {
                    Button(action: {
                        text = ""
                    }, label: {
                        Image(systemName: "multiply.circle.fill")
                    })
                    .padding(.trailing)
                    .modifier(IconViewModifier(isCorrect: $isCorrect))
                }
                
            }
            .frame(height: 50)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(foregroundColor, lineWidth: 1)
            })
            .padding(EdgeInsets(top: 1, leading: 15, bottom: 0, trailing: 15))
        }
    }
}

extension RoundedTextField {
    private var foregroundColor: Color {
        !isCorrect ? .red : .mainTextColor
    }
}

#Preview {
    RoundedTextField(text: .constant("Hagahgahga"), isCorrect: .constant(true), placeholder: "Gym", isEditing: true)
}

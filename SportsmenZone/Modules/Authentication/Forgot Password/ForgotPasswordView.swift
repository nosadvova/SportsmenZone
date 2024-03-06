//
//  ForgotPasswordView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.02.2024.
//

import SwiftUI
import SportUI
import SportExtensions

struct ForgotPasswordView: View {
    @StateObject private var viewModel = ForgotPasswordViewModel()
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        PrimaryScreenStyle(title: S.ForgotPassword.title, textAlignment: .leading, frameAlignment: .leading, description: S.ForgotPassword.description, dismissButton: .back) {
            
            VStack {
                UnderlinedTextField(placeholder: S.email, text: $viewModel.email, isCorrect: $viewModel.isEmailValid)
                
                Spacer()
                
                Button(action: {
                    routerManager.push(.authentication(.otp(isAuthProcess: false, email: viewModel.email)))
                }, label: {
                    Text(S.continue)
                        .frame(width: 200)
                })
                .buttonStyle(RoundButtonStyle(backgroundColor: .sunsetColor, foregroundStyle: .white))
                .disabled(!viewModel.isContinueEnabled)
            }
        }
    }
}

#Preview {
    ForgotPasswordView()
}

//
//  PasswordRecoveryView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.02.2024.
//

import SwiftUI
import SportUI

struct PasswordRecoveryView: View {
    @StateObject private var viewModel = PasswordRecoveryViewModel()
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        PrimaryScreenStyle(title: S.ForgotPassword.resetPassword, textAlignment: .leading, frameAlignment: .leading, description: S.ForgotPassword.description, dismissButton: .back) {
            
            VStack {
                UnderlinedTextField(placeholder: S.password, text: $viewModel.password, isCorrect: $viewModel.isPasswordValid, isSecuredTextField: true)
                UnderlinedTextField(placeholder: S.repeatPassword, text: $viewModel.repeatPassword, isCorrect: $viewModel.arePasswordsEqual, isSecuredTextField: true)
                
                Spacer()
                
                Button(action: {
                    routerManager.replace(with: .login)
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
    PasswordRecoveryView()
}

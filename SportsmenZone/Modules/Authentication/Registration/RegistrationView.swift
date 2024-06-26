//
//  RegistrationView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 24.02.2024.
//

import SwiftUI
import SportUI
import SportExtensions

struct RegistrationView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    @StateObject private var viewModel = RegistrationViewModel()
    
    var body: some View {
        VStack {
            
            Text(S.registration)
                .font(.sport.system(.largeTitle))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Button {
                routerManager.replace(with: .login)
            } label: {
                HStack {
                    Image(systemName: "arrow.backward")
                    Text(S.login)
                }
                .frame(width: 120)
            }
            .padding(.top)
            .frame(maxWidth: .infinity, alignment: .leading)
            .buttonStyle(RoundButtonStyle(sideAlignment: .right, backgroundColor: .mustardColor, foregroundStyle: .white))
            
            Spacer()
            
            registrationFormView
            
            Button {
                routerManager.push(.authentication(.chooseUser))
                viewModel.storeData()
            } label: {
                HStack {
                    Text(S.register)
                        .frame(width: 200)
                }
            }
            .padding(40)
            .disabled(!viewModel.isContinueEnabled)
            .buttonStyle(RoundButtonStyle(sideAlignment: .center, backgroundColor: .sunsetColor, foregroundStyle: .white))
        }
        .background(Color.backgroundColor)
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    RegistrationView()
}

private extension RegistrationView {
    
    private var registrationFormView: some View {
        VStack(spacing: 10) {
            
            UnderlinedTextField(placeholder: S.firstName, text: $viewModel.firstName, isSecuredTextField: false)
            
            UnderlinedTextField(placeholder: S.lastName, text: $viewModel.lastName, isSecuredTextField: false)
            
            UnderlinedTextField(placeholder: S.email, text: $viewModel.email, isCorrect: $viewModel.isEmailValid, isSecuredTextField: false)
            
            UnderlinedTextField(placeholder: S.password, text: $viewModel.password, isCorrect: $viewModel.isPasswordValid, isSecuredTextField: true)
            
            UnderlinedTextField(placeholder: S.repeatPassword, text: $viewModel.repeatPassword, isCorrect: $viewModel.arePasswordsEqual, isSecuredTextField: true)
            
            Text(viewModel.errorText)
                .font(.sport.system(.caption))
                .foregroundStyle(viewModel.isPasswordValid ? Color.inactiveButtonBackgroundColor : .red)
        }
    }
}

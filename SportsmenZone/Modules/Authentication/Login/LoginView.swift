//
//  LoginView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 19.02.2024.
//

import SwiftUI
import SportUI

struct LoginView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            
            Text(S.login)
                .font(.sport.system(.largeTitle))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                        
            VStack(spacing: 20) {
                UnderlinedTextField(placeholder: S.email, text: $viewModel.email, isCorrect: $viewModel.isEmailValid, isSecuredTextField: false)
                
                UnderlinedTextField(placeholder: S.password, text: $viewModel.password, isCorrect: $viewModel.isPasswordValid, isSecuredTextField: true)
                
                Button(action: {
                    routerManager.push(.authentication(.forgotPassword))
                }, label: {
                    Text(S.forgotPassword)
                })
                .modifier(LinkButtonStyle(foregroundColor: .sunsetColor, underlineWidth: 125))
                .padding()
                
                Button {
                    viewModel.loginUser()
                } label: {
                    HStack {
                        Text(S.login)
                            .frame(width: 200)
                    }
                }
                .disabled(!viewModel.isContinueEnabled)
                .buttonStyle(RoundButtonStyle(sideAlignment: .center, backgroundColor: .sunsetColor, foregroundStyle: .white))
            }
            .padding(.top, 30)
            
            Spacer()
            
            Button {
                routerManager
                    .replace(with: [.registration])
            } label: {
                HStack {
                    Text(S.register)
                    Image(systemName: "arrow.forward")
                }
                .frame(width: 120)
            }
            .padding(.bottom, 30)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .buttonStyle(RoundButtonStyle(sideAlignment: .left, backgroundColor: .mustardColor, foregroundStyle: .white))
        }
        .background(Color.backgroundColor)
        .modifier(PopupMessageViewModifier(isPresented: $viewModel.showMessage,
                                           type: .failure,
                                           message: viewModel.requestLoadable.error?.localizedDescription ?? "Bad response"))
        .onChange(of: viewModel.requestLoadable.value) { oldValue, newValue in
            Task {
                if viewModel.requestLoadable == .loaded(true) {
                    routerManager.replace(with: .gym(.gym))
                }
                viewModel.requestLoadable = .notRequested
            }
        }
    }
}

#Preview {
    LoginView()
}

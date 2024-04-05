//
//  OTPView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 26.02.2024.
//

import SwiftUI
import SportUI

struct OTPView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    @StateObject var viewModel: OTPViewModel
    @FocusState var pinFocusState: FocusPin?

    var body: some View {
        PrimaryScreenStyle(title: S.Otp.title, textAlignment: .leading, frameAlignment: .leading, description: S.Otp.description, dismissButton: .back) {
            
            Spacer()
            
            VStack(spacing: 20) {
                Text(viewModel.email)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .frame(alignment: .center)
                
                OTPTextField
                    .padding(.vertical)
                
                HStack {
                    Text(S.Otp.didntReceive)
                        .font(.sport.system(.title2))
                    
                    Button(action: {
                        // viewModel.sendOTPAgain()
                    }, label: {
                        Text(S.Otp.resendCode)
                    })
                    .modifier(LinkButtonStyle(underlineWidth: 90))
                }
            }
            
            Spacer()
            
            Button(action: {
                viewModel.isAuthProcess ? routerManager.push( .authentication(.authorizationSuccess)) : routerManager.push(.authentication(.passwordRecovery))
            }, label: {
                Text(S.continue)
                    .frame(width: 200)
            })
            .disabled(!viewModel.isContinueEnabled)
            .buttonStyle(RoundButtonStyle(backgroundColor: .sunsetColor, foregroundStyle: .white))
        }
    }
}

private extension OTPView {
    var OTPTextField: some View {
        HStack(spacing: 15) {
            TextField("", text: $viewModel.pinOne)
                .modifier(OtpModifer(pin: $viewModel.pinOne))
                .onChange(of: viewModel.pinOne) { oldVal, newVal in
                    if newVal.count == 1 {
                        pinFocusState = .pinTwo
                    }
                }
                .focused($pinFocusState, equals: .pinOne)
            
            TextField("", text: $viewModel.pinTwo)
                .modifier(OtpModifer(pin: $viewModel.pinTwo))
                .onChange(of: viewModel.pinTwo) { oldVal, newVal in
                    if newVal.count == 1 {
                        pinFocusState = .pinThree
                    } else if newVal.count == 0 {
                        pinFocusState = .pinOne
                    }
                }
                .focused($pinFocusState, equals: .pinTwo)
            
            TextField("", text: $viewModel.pinThree)
                .modifier(OtpModifer(pin: $viewModel.pinThree))
                .onChange(of: viewModel.pinThree) { oldVal, newVal in
                    if newVal.count == 1 {
                        pinFocusState = .pinFour
                    } else if newVal.count == 0 {
                        pinFocusState = .pinTwo
                    }
                }
                .focused($pinFocusState, equals: .pinThree)
            
            TextField("", text: $viewModel.pinFour)
                .modifier(OtpModifer(pin: $viewModel.pinFour))
                .onChange(of: viewModel.pinFour) { oldVal, newVal in
                    if newVal.count == 0 {
                        pinFocusState = .pinThree
                    }
                }
                .focused($pinFocusState, equals: .pinFour)
        }
    }
}

#Preview {
    OTPView(viewModel: OTPViewModel(isAuthProcess: true, email: "dabitebi3@gmail.com"))
}

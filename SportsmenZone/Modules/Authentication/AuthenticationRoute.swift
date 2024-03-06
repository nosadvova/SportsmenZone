//
//  AuthenticationRouter.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.02.2024.
//

import SwiftUI

enum AuthenticationRoute {
    case forgotPassword
    case otp(isAuthProcess: Bool, email: String)
    case passwordRecovery
    case chooseUser
    case authorizationSuccess
}

extension AuthenticationRoute: View {
    var body: some View {
        switch self {
        case .forgotPassword:
            ForgotPasswordView()
        case .otp(let isAuthProcess, let email):
            OTPView(viewModel: OTPViewModel(isAuthProcess: isAuthProcess, email: email))
        case .passwordRecovery:
            PasswordRecoveryView()
        case .chooseUser:
            ChooseUserView()
        case .authorizationSuccess:
            AuthorizationSuccessView()
        }
    }
}

extension AuthenticationRoute: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}

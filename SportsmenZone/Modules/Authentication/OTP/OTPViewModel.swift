//
//  OTPViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 26.02.2024.
//

import SwiftUI
import Combine

enum FocusPin {
    case pinOne, pinTwo, pinThree, pinFour
}

final class OTPViewModel: ObservableObject {
    @Published var pinOne: String = ""
    @Published var pinTwo: String = ""
    @Published var pinThree: String = ""
    @Published var pinFour: String = ""
    
    @Published var otpCode: String = ""
    @Published var isContinueEnabled = false
    
    let isAuthProcess: Bool
    let email: String
    let otpValidCode = "1234"
    
    private var cancellables = Set<AnyCancellable>()
    
    init(isAuthProcess: Bool, email: String) {
        self.isAuthProcess = isAuthProcess
        self.email = email
        
        setupBindings()
    }
    
//    func checkVerificationCode(_ code: String) -> Bool {
//        if otpCode.count != 4 && otpCode != code {
//            return false
//        }
//        return true
//    }
    
    private func setupBindings() {
        
        Publishers.CombineLatest4($pinOne, $pinTwo, $pinThree, $pinFour)
            .map { pinOne, pinTwo, pinThree, pinFour in
                return pinOne + pinTwo + pinThree + pinFour
            }
            .assign(to: \.otpCode, on: self)
            .store(in: &cancellables)
        
        $otpCode
            .map {
                guard $0.count == 4 && $0 == self.otpValidCode else { return false }
                return true
            }
            .assign(to: \.isContinueEnabled, on: self)
            .store(in: &cancellables)
    }
}


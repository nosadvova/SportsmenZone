//
//  PasswordRecoveryViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.02.2024.
//

import SwiftUI
import Combine

final class PasswordRecoveryViewModel: ObservableObject {
    @Published var password: String = ""
    @Published var repeatPassword: String = ""
    
    @Published var isPasswordValid = true
    @Published var arePasswordsEqual = false
    @Published var isContinueEnabled = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map {
                guard !$0.isEmpty else { return true }
                return $0.isPasswordValid
            }
            .assign(to: \.isPasswordValid, on: self)
            .store(in: &cancellables)
        
        Publishers
            .CombineLatest3($password, $repeatPassword, $isPasswordValid)
            .map { password, repeatPassword, isPasswordValid in
                guard !repeatPassword.isEmpty && !password.isEmpty else { return true }
                                
                return (password == repeatPassword) && isPasswordValid
            }
            .assign(to: \.arePasswordsEqual, on: self)
            .store(in: &cancellables)
        
        $isPasswordValid
            .combineLatest($arePasswordsEqual)
            .map { isPasswordValid, arePasswordsEqual in
                guard !self.repeatPassword.isEmpty && !self.password.isEmpty else { return false }
                return isPasswordValid && arePasswordsEqual
            }
            .assign(to: \.isContinueEnabled, on: self)
            .store(in: &cancellables)
    }
}

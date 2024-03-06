//
//  RegistrationViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 24.02.2024.
//

import SwiftUI
import Combine

final class RegistrationViewModel: ObservableObject {
    @Published var fullName: String = ""
    @Published var email: String = "asdfrt@gmail.com"
    @Published var password: String = "123456"
    @Published var repeatPassword: String = "123456"
    @Published var errorText: String = ""
    
    @Published var isFullNameValid = false
    @Published var isEmailValid = true
    @Published var isPasswordValid = true
    @Published var arePasswordsEqual = false
    @Published var isContinueEnabled = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        $fullName
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { !$0.isEmpty }
            .assign(to: \.isFullNameValid, on: self)
            .store(in: &cancellables)
        
        $email
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map {
                guard !$0.isEmpty else { return true }
                return $0.isEmailValid
            }
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellables)
        
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
                guard !repeatPassword.isEmpty else { return true }
                
                self.errorText = isPasswordValid ? "" : S.RegisterPassword.notValid
                
                return (password == repeatPassword) && isPasswordValid
            }
            .assign(to: \.arePasswordsEqual, on: self)
            .store(in: &cancellables)
        
        
        Publishers
            .CombineLatest3($isFullNameValid, $isEmailValid, $arePasswordsEqual)
            .map { isFullNameValid, isEmailValid, arePasswordsEqual in
                guard !self.password.isEmpty &&
                        !self.repeatPassword.isEmpty &&
                        !self.fullName.isEmpty
                else { return false }
                
                return isFullNameValid && isEmailValid && arePasswordsEqual
            }
            .assign(to: \.isContinueEnabled, on: self)
            .store(in: &cancellables)
    }
}

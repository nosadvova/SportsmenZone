//
//  LoginViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 23.02.2024.
//

import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isEmailValid = true
    @Published var isPasswordValid = true
    @Published var isContinueEnabled = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
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
            .CombineLatest($isEmailValid, $isPasswordValid)
            .map { isEmailValid, isPasswordValid in
                guard !self.email.isEmpty && !self.password.isEmpty else {
                    return false
                }
                return isEmailValid && isPasswordValid
            }
            .assign(to: \.isContinueEnabled, on: self)
            .store(in: &cancellables)   
    }
}

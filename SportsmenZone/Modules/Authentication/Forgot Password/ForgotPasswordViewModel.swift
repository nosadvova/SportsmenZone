//
//  ForgotPasswordViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.02.2024.
//

import SwiftUI
import Combine

final class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    
    @Published var isEmailValid = true
    @Published var isContinueEnabled = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $email
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map {
                guard !$0.isEmpty else { return true }
                return $0.isEmailValid
            }
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellables)
        
        $isEmailValid
            .map {
                guard !self.email.isEmpty else { return false }
                return $0
            }
            .assign(to: \.isContinueEnabled, on: self)
            .store(in: &cancellables)
    }
}

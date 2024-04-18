//
//  LoginViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 23.02.2024.
//

import SwiftUI
import Combine
import SportUI

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = "trainer@gmail.com"
    @Published var password: String = "123456"
    
    @Published var isEmailValid = true
    @Published var isPasswordValid = true
    @Published var isContinueEnabled = false
    @Published var requestLoadable: Loadable<Bool> = .notRequested
    @Published var showMessage: (Bool, String) = (false, "")
    
    private var networkService: AuthenticationAPI
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: AuthenticationAPI = RealAuthenticationAPI()) {
        self.networkService = networkService
        setupBindings()
    }
    
    func loginUser() {
        Task {
            requestLoadable.loading()
            do {
                let token = try await networkService.login(email: email, password: password)
//                print(token)
                requestLoadable = .loaded(true)
            } catch let error as NetworkError {
                print("Login error: ", error.customMessage)
                showMessage = (true, error.customMessage)
                requestLoadable = .failed(error)
            }
        }
    }
    
    private func setupBindings() {
        $email
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map {
                guard !$0.isEmpty else { return true }
                return $0.isEmailValid
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellables)
        
        $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map {
                guard !$0.isEmpty else { return true }
                return $0.isPasswordValid
            }
            .receive(on: DispatchQueue.main)
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
            .receive(on: DispatchQueue.main)
            .assign(to: \.isContinueEnabled, on: self)
            .store(in: &cancellables)   
    }
}

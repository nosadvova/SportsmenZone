//
//  RegistrationViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 24.02.2024.
//

import SwiftUI
import Models
import Combine

final class RegistrationViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var repeatPassword: String = ""
    @Published var errorText: String = ""
    
    @Published var isFirstNameValid = false
    @Published var isLastNameValid = false
    @Published var isEmailValid = true
    @Published var isPasswordValid = true
    @Published var arePasswordsEqual = false
    @Published var isContinueEnabled = false
    
    private var cancellables = Set<AnyCancellable>()
    private var globalDataStorage: GlobalDataStorage
    
    init(
        globalDataStorage: GlobalDataStorage = GlobalDataStorage.shared
    ) {
        self.globalDataStorage = globalDataStorage
        setupBindings()
    }
    
    func storeData() {
        Task {
            let user = await globalDataStorage.user
            
            let newPersonalInfo = (user?.personalInformation ?? PersonalInformation())
                .copy(firstName: firstName, lastName: lastName, password: password, email: email)
            await globalDataStorage.setData(personalInformation: newPersonalInfo)
        }
    }
    
    private func setupBindings() {
        $firstName
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { !$0.isEmpty }
            .assign(to: \.isFirstNameValid, on: self)
            .store(in: &cancellables)
        
        $lastName
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { !$0.isEmpty }
            .assign(to: \.isLastNameValid, on: self)
            .store(in: &cancellables)
        
        $email
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map {
                guard !$0.isEmpty else { return false }
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
            .CombineLatest4($isFirstNameValid, $isLastNameValid, $isEmailValid, $arePasswordsEqual)
            .map { isFirstNameValid, isLastNameValid, isEmailValid, arePasswordsEqual in
                guard !self.password.isEmpty &&
                        !self.repeatPassword.isEmpty
                else { return false }
                
                return isFirstNameValid && isLastNameValid && isEmailValid && arePasswordsEqual
            }
            .assign(to: \.isContinueEnabled, on: self)
            .store(in: &cancellables)
    }
}

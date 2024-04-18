//
//  OTPViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 26.02.2024.
//

import SwiftUI
import Combine
import SportUI
import Models

enum FocusPin {
    case pinOne, pinTwo, pinThree, pinFour
}

@MainActor
final class OTPViewModel: ObservableObject {
    @Published var pinOne: String = ""
    @Published var pinTwo: String = ""
    @Published var pinThree: String = ""
    @Published var pinFour: String = ""
    
    @Published var otpCode: String = ""
    @Published var isContinueEnabled = false
    @Published var showMessage = (false, "")
    @Published var requestLoadable: Loadable<Bool> = .notRequested
    
    let isAuthProcess: Bool
    let email: String
    let otpValidCode = "1234"
    
    private var networkService: AuthenticationAPI
    private var globalDataStorage: GlobalDataStorage
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: AuthenticationAPI = RealAuthenticationAPI(),
         globalDataStorage: GlobalDataStorage = GlobalDataStorage.shared,
         isAuthProcess: Bool,
         email: String) {
        self.networkService = networkService
        self.globalDataStorage = globalDataStorage
        self.isAuthProcess = isAuthProcess
        self.email = email
        
        setupBindings()
    }
    
    func registerUser() {
        Task {
            guard let personalInformation = await globalDataStorage.personalInformation else { return }
            let userInformation = UserInformationModel(firstName: personalInformation.firstName ?? "",
                                                       lastName: personalInformation.lastName ?? "",
                                                       password: personalInformation.password ?? "",
                                                       email: personalInformation.email ?? "",
                                                       userType: personalInformation.userType?.rawValue ?? "")
            
            requestLoadable.loading()
            do {
                _ = try await networkService.register(personalInformation: userInformation)
                requestLoadable = .loaded(true)
            } catch let error as NetworkError {
                print("Error while sending request: ", error.customMessage)
                showMessage = (true, error.customMessage)
                requestLoadable = .failed(error)
            }
        }
    }
    
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


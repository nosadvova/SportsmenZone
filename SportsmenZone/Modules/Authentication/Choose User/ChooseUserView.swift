//
//  ChooseUserView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 28.02.2024.
//

import SwiftUI
import SportUI

enum UserType: String, Identifiable, CaseIterable {
    case sportsmen = "Sportsmen"
    case trainer = "Trainer"
    
    var id: Self { self }
}

struct ChooseUserView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    @StateObject private var viewModel = ChooseUserViewModel()
    @State private var chosenUserType: UserType?
    @State private var isSportsmenSelected = false
    @State private var isTrainerSelected = false
    
    var body: some View {
        PrimaryScreenStyle(title: S.ChooseUser.title, description: S.ChooseUser.description, dismissButton: .back) {
            Spacer()
            HStack(spacing: 80) {
                ChooseItemButton(title: S.ChooseUser.sportsmen,
                                 description: S.ChooseUser.sportsmenDescription,
                                 image: Image(systemName: "person.fill"),
                                 isSelected: $isSportsmenSelected,
                                 action: {
                    chosenUserType = .sportsmen
                    isSportsmenSelected = true
                    isTrainerSelected = false
                })
                
                ChooseItemButton(title: S.ChooseUser.trainer,
                                 description: S.ChooseUser.trainerDescription,
                                 image: Image(systemName: "person.fill"),
                                 isSelected: $isTrainerSelected,
                                 action: {
                    chosenUserType = .trainer
                    isSportsmenSelected = false
                    isTrainerSelected = true
                })
            }
            
            Spacer()
            
            Button {
                routerManager.push(.authentication(.otp(isAuthProcess: true, email: viewModel.email)))
            } label: {
                Text(S.continue)
                    .frame(width: 200)
            }
            .disabled(!(chosenUserType != nil))
            .buttonStyle(RoundButtonStyle(backgroundColor: .sunsetColor, foregroundStyle: .white))
        }
    }
}

#Preview {
    ChooseUserView()
}

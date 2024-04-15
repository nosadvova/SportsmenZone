//
//  ChooseUserView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 28.02.2024.
//

import SwiftUI
import SportUI
import Models

struct ChooseUserView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    @StateObject private var viewModel = ChooseUserViewModel()
    
    var body: some View {
        PrimaryScreenStyle(title: S.ChooseUser.title, description: S.ChooseUser.description, dismissButton: .back) {
            Spacer()
            HStack(spacing: 80) {
                ChooseItemButton(title: S.ChooseUser.sportsmen,
                                 description: S.ChooseUser.sportsmenDescription,
                                 image: Image(systemName: "person.fill"),
                                 isSelected: $viewModel.isSportsmenSelected,
                                 action: {
                    viewModel.chosenUserType = .Sportsman
                    viewModel.isSportsmenSelected = true
                    viewModel.isTrainerSelected = false
                })
                
                ChooseItemButton(title: S.ChooseUser.trainer,
                                 description: S.ChooseUser.trainerDescription,
                                 image: Image(systemName: "person.fill"),
                                 isSelected: $viewModel.isTrainerSelected,
                                 action: {
                    viewModel.chosenUserType = .Trainer
                    viewModel.isSportsmenSelected = false
                    viewModel.isTrainerSelected = true
                })
            }
            
            Spacer()
            
            Button {
                viewModel.storeData()
                routerManager.push(.authentication(.otp(isAuthProcess: true, email: viewModel.email)))
            } label: {
                Text(S.continue)
                    .frame(width: 200)
            }
            .disabled(viewModel.chosenUserType == nil)
            .buttonStyle(RoundButtonStyle(backgroundColor: .sunsetColor, foregroundStyle: .white))
        }
    }
}

#Preview {
    ChooseUserView()
}

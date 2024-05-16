//
//  AccountView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 07.05.2024.
//

import SwiftUI
import SportUI

struct AccountView: View {
    @StateObject private var viewModel = AccountViewModel()
    @EnvironmentObject private var routerManager: NavigationRouter
    @State private var showSettings = false
    @State private var isChanged = false
    
    var body: some View {
        ZStack {
            PrimaryScreenStyle(title: "Profile", textAlignment: .center, frameAlignment: .leading, backgroundColor: .white) {
                VStack(spacing: 20) {
                    Image(viewModel.personalInformation?.userImage ?? "placeholder-image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 135, height: 135)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    personalInformationView
                        .padding(.top)
                    
                    gymView
                        .padding(.top)
                    
                    Spacer()
                    
                    Button {
                        print("Tapped save changes account")
                    } label: {
                        Text("Save changes")
                            .font(.sport.system(.button))
                            .frame(width: 200)
                    }
                    .buttonStyle(RoundButtonStyle(backgroundColor: .green, foregroundStyle: .white))
                    .disabled(!isChanged)
                }
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    showSettings = true
                } label: {
                    Image(systemName: "gearshape")
                        .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 25))
                        .imageScale(.large)
                        .foregroundStyle(.black)
                }
            }
            
            SliderView(showModal: $showSettings) {
                OptionButton(image: "door.right.hand.open", imageColor: .red, title: "Log out") {
                    Task {
                        await viewModel.clearAuthToken()
                    }
                    routerManager.replace(with: .login)
                }
                .padding(.horizontal, 10)
                .foregroundStyle(.white)
            }
        }
    }
}

extension AccountView {
    var personalInformationView: some View {
        VStack(alignment: .leading) {
            Text("Personal information")
                .padding(.bottom, 10)
                .font(.sport.system(.title2))
            
            VStack(spacing: 25) {
                UnderlinedTextField(placeholder: S.firstName, text: $viewModel.firstName, headerDisabled: true, defaultBorderColor: .lightGrayColor)
                    .onChange(of: viewModel.firstName) { oldValue, newValue in
                        isChanged = viewModel.checkChanges(newValue: newValue, oldValue: viewModel.originalFirstName)
                    }
                
                UnderlinedTextField(placeholder: S.lastName, text: $viewModel.lastName, headerDisabled: true, defaultBorderColor: .lightGrayColor)
                    .onChange(of: viewModel.lastName) { oldValue, newValue in
                        isChanged = viewModel.checkChanges(newValue: newValue, oldValue: viewModel.originalLastName)
                    }
                
                UnderlinedTextField(placeholder: S.email, text: $viewModel.email, headerDisabled: true, underlineDisabled: true)
                    .onChange(of: viewModel.email) { oldValue, newValue in
                        isChanged = newValue.isEmailValid && viewModel.checkChanges(newValue: newValue, oldValue: viewModel.originalEmail)
                    }
            }
            .padding(.vertical)
            .modifier(RoundedViewModifier(color: .white))
        }
    }
    
    var gymView: some View {
        VStack(alignment: .leading) {
            Text("Gym")
                .padding(.bottom, 10)
                .font(.sport.system(.title2))
            
            if viewModel.personalInformation?.gym != nil {
                Button {
                    routerManager.selectedTab = .gym
                } label: {
                    HStack {
                        Image(viewModel.gym?.image ?? "placeholder-image")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.gym?.name ?? "")
                                .font(.sport.system(.body))
                                .foregroundStyle(Color.mainTextColor)
                            
                            Text(viewModel.gym?.description ?? "")
                                .font(.sport.system(.caption))
                                .multilineTextAlignment(.leading)
                                .minimumScaleFactor(0.5)
                                .foregroundStyle(.gray)
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .modifier(RoundedViewModifier(color: .white))
                }
            } else {
                HStack(spacing: 20) {
                    Image(systemName: "magnifyingglass")
                    Text("Find new gym")
                        .padding(.trailing)
                }
                .font(.sport.system(.button))
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.oliveColor)
                .modifier(RoundedViewModifier(color: .white))
                .onTapGesture {
                    routerManager.selectedTab = .search
                }
            }
        }
    }
}

#Preview {
    AccountView()
}

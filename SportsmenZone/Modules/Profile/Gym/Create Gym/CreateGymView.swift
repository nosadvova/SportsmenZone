//
//  CreateGymView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 02.05.2024.
//

import SwiftUI
import SportUI
import Models

struct CreateGymView: View {
    @StateObject private var viewModel = CreateGymViewModel()
    
    var body: some View {
        PrimaryScreenStyle(title: S.Gym.createNewGym, dismissButton: .close, backgroundColor: .backgroundColor) {
            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    roundedTextField(S.Gym.name, showTitle: true, text:  $viewModel.name)
                    roundedTextField(S.Gym.description, showTitle: true, text:  $viewModel.description)
                    
                    ExpandableView(title: "Add new location", image: Image(systemName: "plus.circle.fill")) {
                        VStack {
                            horizontalTextField(S.Gym.city, text:  $viewModel.city)
                            Divider()
                            horizontalTextField(S.Gym.district, text:  $viewModel.district)
                            Divider()
                            horizontalTextField(S.Gym.street, text:  $viewModel.street)
                            Divider()
                            horizontalTextField(S.Gym.buildingNumber, text:  $viewModel.buildingNumber)
                        }
                        .padding(.vertical, 5)
                    }
                    .modifier(RoundedViewModifier(title: S.Gym.addGymLocation, color: .white))
                    
                    HStack {
                        sportTypeMenu
                            .padding(15)
                            .modifier(RoundedViewModifier(title: "\(S.Gym.chooseSportTypes):", color: .white, opacity: 0.7))
                            .font(.sport.system(.body))
                            .foregroundStyle(.black)
                        
                        Spacer()
                    }
                    
                    Button {
                        viewModel.createNewGym()
                    } label: {
                        Text(S.save)
                            .font(.sport.system(.button))
                            .frame(width: 200)
                    }
                    .disabled(!viewModel.isFormValid)
                    .buttonStyle(RoundButtonStyle(backgroundColor: .green, foregroundStyle: .white))
                }
            }
        }
        .modifier(PopupMessageViewModifier(isPresented: $viewModel.showMessage.0, type: .failure, message: viewModel.showMessage.1))
    }
}

extension CreateGymView {
    var sportTypeMenu: some View {
        HStack {
            Menu {
                ScrollView {
                    VStack {
                        ForEach(SportType.allCases, id: \.self) { type in
                            Button(action: {
                                viewModel.pickType(sportType: type)
                            }) {
                                HStack {
                                    if viewModel.type.contains(type) {
                                        Image(systemName: "checkmark")
                                    }
                                    Image(systemName: type.image)
                                    Text(type.displayName)
                                }
                            }
                        }
                    }
                }
            } label: {
                Label {
                    Text(viewModel.sportTypeLabel)
                        .padding(.leading, 15)
                } icon: {
                    Image(systemName: "chevron.down.circle")
                        .imageScale(.medium)
                        .padding(.bottom, 5)
                }
            }
            
            Spacer()
        }
        .font(.sport.system(.button))
        .padding(.horizontal, 5)
    }
    
    func horizontalTextField(_ title: String, text: Binding<String>) -> some View {
        HStack {
            Text(title)
                .font(.sport.system(.body))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .minimumScaleFactor(0.5)
                .lineLimit(2)
                        
            TextField(title, text: text, axis: .vertical)
                .padding(8)
                .font(.sport.system(.body))
                .frame(maxWidth: .infinity, alignment: .leading)
                .minimumScaleFactor(0.5)
                .modifier(RoundedViewModifier(color: .white))
        }
        .padding(EdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10))
    }
    
    func roundedTextField(_ title: String, showTitle: Bool = false, text: Binding<String>) -> some View {
        DefaultTextField(text: text, placeholder: title)
            .modifier(RoundedViewModifier(title: showTitle ? "\(title):" : "", color: .white))
    }
}

#Preview {
    CreateGymView()
}

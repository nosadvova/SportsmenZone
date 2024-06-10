//
//  MainPageView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 07.05.2024.
//

import SwiftUI
import SportUI

struct MainPageView: View {
    @StateObject var viewModel: AppViewModel
    @EnvironmentObject var routerManager: NavigationRouter
    
    var body: some View {
        ShapeHeaderScreenStyle(title: "Welcome back, \(viewModel.fullName)!", description: "What would you like to do next?", color: .oliveColor) {
            VStack(spacing: 15) {
                titleView(title: "Your gym:")
                    .padding(.top, 10)
                
                gymView
                    .padding(.horizontal)
                
                titleView(title: "Latest notifications:")
                
                notificationList
                    .modifier(RoundedViewModifier(color: .white, opacity: 0.6))
                    .padding(.horizontal)
            }
        }
        .modifier(LoadingViewModifier(isLoading: viewModel.requestLoadable.isLoading, opacity: 0))
    }
}

private extension MainPageView {
    private func titleView(title: String) -> some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.medium)
                .padding(.leading, 5)
            Spacer()
        }
        .padding(.vertical, 10)
        .background(Color.oliveColor.opacity(0.2))
        .cornerRadius(12)
        .padding(.horizontal)
        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
    }
}

private extension MainPageView {
    var notificationList: some View {
        List {
            ForEach(viewModel.notifications) { notification in
                UserRow(isInteractionAllowed: false, isSystemImage: true, userImage: notification.type?.image, fullName: notification.title ?? "", info: notification.message ?? "") {
                    EmptyView()
                }
                    .foregroundStyle(notification.type?.rawValue == "Major" ? .yellow : .green)
            }
            .ignoresSafeArea()
        }
        .frame(width: 350)
        .listStyle(.plain)
    }
    
    var gymView: some View {
        VStack(alignment: .leading) {
            if viewModel.gym != nil {
                Button {
                    routerManager.selectedTab = .gym
                } label: {
                    HStack {
                        Image(systemName: viewModel.gymImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.black)
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
            }
        }
    }
}


#Preview {
    MainPageView(viewModel: AppViewModel())
}

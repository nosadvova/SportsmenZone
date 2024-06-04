//
//  GymView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 05.03.2024.
//

import SwiftUI
import SportUI
import Models
import SportExtensions

struct GymView: View {
    @StateObject var viewModel: GymViewModel
    @EnvironmentObject private var routerManager: NavigationRouter
    @State private var isTrainingSheetPresented = false
    @State private var showCreateGymSheet = false
    
    var body: some View {
        VStack {
            if let gym = viewModel.gym {
                ShapeHeaderScreenStyle(title: gym.name ?? "", description: gym.description, color: .darkBlueColor, dismissButton: viewModel.isHomeScreen ?? true ? NavigationIcon.none : .back, foregroundColor: .white, content: {
                    ScrollView(showsIndicators: false) {
                        if viewModel.user?.personalInformation?.userType == UserType.Sportsman.rawValue {
                            followButton
                        }
                        
                        HStack {
                            Text(S.Gym.allSportsmen)
                                .font(.sport.system(.title))
                                .foregroundStyle(Color.gray)
                            
                            Spacer()
                        }
                        .padding(.top, 15)
                        
                        sportsmenList
                        
                        HStack {
                            Text(S.Gym.trainings)
                                .font(.sport.system(.title))
                                .foregroundStyle(Color.gray)
                            
                            Spacer()
                            
                            if viewModel.isOwner {
                                Button {
                                    routerManager.push(.gym(.training(isOwner: viewModel.isOwner)))
                                } label: {
                                    HStack {
                                        Text("Add")
                                        Image(systemName: "plus")
                                    }
                                    .padding(.trailing, 13)
                                    .foregroundStyle(Color.darkBlueColor)
                                }
                            }
                        }
                        .padding(.top, 20)
                        
                        trainingsSliderView
                    }
                })
                .overlay(alignment: .topTrailing) {
                    if viewModel.isUserSubscriber {
                        Button {
                            routerManager.push(.gym(.notifications))
                        } label: {
                            Image(systemName: "bell.fill")
                                .imageScale(.medium)
                                .foregroundStyle(.white)
                        }
                        .offset(x: -20, y: 40)
                    }
                }
                .background(Color.backgroundColor)
            } else {
                newGymButton
                Spacer()
            }
        }
        .modifier(LoadingViewModifier(isLoading: viewModel.requestLoadable.isLoading))
        .refreshable {
            viewModel.getGym()
        }
    }
}

private extension GymView {
    var newGymButton: some View {
        VStack(alignment: .leading) {
            if viewModel.user?.personalInformation?.userType == UserType.Sportsman.rawValue {
                Button {
                    routerManager.selectedTab = .gym
                } label: {
                    HStack(spacing: 20) {
                        Image(systemName: "magnifyingglass")
                        Text("Find new gym")
                            .padding(.trailing)
                    }
                    .font(.sport.system(.button))
                    .padding()
                    .foregroundStyle(Color.oliveColor)
                    .modifier(RoundedViewModifier(color: .white))
                    .onTapGesture {
                        routerManager.selectedTab = .search
                    }
                }
            } else {
                Button {
                    showCreateGymSheet = true
                } label: {
                    HStack(spacing: 15) {
                        Image(systemName: "plus")
                        Text(S.Gym.createNewGym)
                    }
                }
                .buttonStyle(RoundButtonStyle(backgroundColor: .darkBlueColor, foregroundStyle: .white))
                .sheet(isPresented: $showCreateGymSheet, content: {
                    CreateGymView()
                })
            }
        }
        .padding(.top, 40)
    }
    
    var followButton: some View {
        VStack {
            if viewModel.isUserSubscriber {
                HStack {
                    Text(S.Gym.unfollowLabel)
                        .font(.sport.system(.caption))
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                        .padding(.trailing, 20)
                        .foregroundStyle(Color.gray)
                    
                    Button {
                        //
                    } label: {
                        Text(S.Gym.unfollowButton)
                            .frame(width: 100)
                    }
                    .frame(height: 30)
                    .buttonStyle(RectangleButtonStyle(backgroundColor: .white, foregroundStyle: .red))
                }
            } else {
                HStack {
                    Text(S.Gym.followLabel)
                        .font(.sport.system(.caption))
                        .padding(.trailing, 20)
                        .foregroundStyle(Color.gray)
                    
                    Button {
                        viewModel.followGym()
                    } label: {
                        Text(S.Gym.followButton)
                            .frame(width: 100)
                    }
                    .frame(height: 30)
                    .buttonStyle(RectangleButtonStyle(backgroundColor: .mainTextColor, foregroundStyle: .white))
                }
            }
        }
    }
    
    var sportsmenList: some View {
        VStack {
            let usersToShow = viewModel.sportsmen.prefix(4)
            
            ForEach(usersToShow) { sportsman in
                VStack {
                    UserRow(
                        isInteractionAllowed: false,
                        userImage: sportsman.personalInformation?.userImage,
                        fullName: sportsman.personalInformation?.fullName ?? "",
                        info: sportsman.personalInformation?.email ?? "") {}
                }
                .padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 25))
            }
            
            if viewModel.sportsmen.count > 4 {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 1)
                    .foregroundStyle(Color.lightGrayColor)
                    .padding(.horizontal)
                
                Button(action: {
                    print("Taped")
                    routerManager.push(.gym(.allSportsmen(gym: viewModel.gym)))
                }, label: {
                    HStack {
                        Text("Show more")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.forward.circle.fill")
                    }
                })
                .foregroundStyle(Color.defaultBorderColor)
                .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 5))
        )
    }
    
    var trainingsSliderView: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.trainings) { training in
                        VStack(alignment: .leading) {
                            Text(training.trainingDay.displayName)
                                .font(.sport.system(.title2))
                            
                            Divider()
                            
                            Text("Name: \(training.name)")
                                .font(.caption)
                            
                            Text("Time: \(training.time.trainingTime())")
                                .font(.caption)
                            
                            Text("Duration: \(training.duration) hours")
                                .font(.caption)
                            
                            Text("Commentary: \(training.commentary)")
                                .font(.caption)
                        }
                        .padding(20)
                        .frame(maxWidth: 350, maxHeight: 250)
                        .containerRelativeFrame(.horizontal)
                        .onTapGesture {
                            isTrainingSheetPresented = true
                        }
                        .sheet(isPresented: $isTrainingSheetPresented) {
                            TrainingView(viewModel: TrainingViewModel(training: training, isOwner: viewModel.isOwner))
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                        )
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }
}


#Preview {
    GymView(viewModel: GymViewModel(gym: MockData.gym1))
}

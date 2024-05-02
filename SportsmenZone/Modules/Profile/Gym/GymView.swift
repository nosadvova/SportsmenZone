//
//  GymView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 05.03.2024.
//

import SwiftUI
import SportUI
import SportExtensions

struct GymView: View {
    @StateObject private var viewModel = GymViewModel()
    @EnvironmentObject private var routerManager: NavigationRouter
    @State private var isTrainingSheetPresented = false
    
    @StateObject private var appViewModel = AppViewModel()
    
    var body: some View {
        ShapeHeaderScreenStyle(title: "Gym", description: "Description of the gym dfhdsfjdhfjdhfj dfhdsfjdhfjdhfj dfhdsfjdhfjdhfj dfhdsfjdhfjdhfj dfhdsfjdhfjdhfj dfhdsfjdhfjdhfj dfhdsfjdhfjdhfj dfhdsfjdhfjdhfj", color: .darkBlueColor, foregroundColor: .white, content: {
            ScrollView {
                followButton
                
                HStack {
                    Text(S.Gym.allSportsmen)
                        .font(.sport.system(.title))
                        .foregroundStyle(Color.gray)
                    
                    Spacer()
                }
                
                sportsmenList
                
                HStack {
                    Text(S.Gym.allSportsmen)
                        .font(.sport.system(.title))
                        .foregroundStyle(Color.gray)
                    
                    Spacer()
                }
                .padding(.top, 20)
                
                trainingsSliderView
            }
        })
        .background(Color.backgroundColor)
//        .task {
//            await appViewModel.getUser()
//        }
    }
}

private extension GymView {
    var followButton: some View {
        HStack {
            Text(S.Gym.followLabel)
                .font(.sport.system(.caption))
                .padding(.trailing, 20)
                .foregroundStyle(Color.gray)
            
            Button {
                Task {
                    await appViewModel.getUser()
                }
            } label: {
                Text(S.Gym.followButton)
                    .frame(width: 100)
            }
            .frame(height: 30)
            .buttonStyle(RectangleButtonStyle(backgroundColor: .mainTextColor, foregroundStyle: .white))
        }
        .padding(.vertical)
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
                    routerManager.push(.gym(.allSportsmen))
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
                            Text(training.trainingDay.rawValue)
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
                            TrainingView(viewModel: TrainingViewModel(training: training), user: MockData.user4)
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
    GymView()
}

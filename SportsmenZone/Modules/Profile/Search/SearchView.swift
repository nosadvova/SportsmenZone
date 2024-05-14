//
//  SearchView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 09.05.2024.
//

import SwiftUI
import SportUI
import Models

struct SearchView: View {
    @State private var text: String = ""
    @State private var isLoading = false
    @State private var showAddress = false
    @State private var locationDetails = ""
    @StateObject private var viewModel = SearchViewModel()
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var searchResults: [Gym] {
        guard let gyms = viewModel.gyms else { return [] }
        if text.isEmpty {
            return gyms
        } else {
            return gyms.filter { $0.name?.lowercased().contains(text.lowercased()) ?? false } 
        }
    }
    
    var body: some View {
        PrimaryScreenStyle(title: "Find gym") {
            VStack {
                SearchBar(text: $text, isLoading: $isLoading)
                
                gymList
            }
        }
        .modifier(LoadingViewModifier(isLoading: viewModel.requestLoadable.isLoading))
        .overlay {
            AlertView(isActive: $showAddress, title: "Gym location", buttonTitle: "Dismiss") {
                Text(locationDetails)
                    .padding()
                    .font(.sport.system(.button))
            }
        }
    }
}

extension SearchView {
    var gymList: some View {
        List {
            ForEach(searchResults) { gym in
                HStack {
                    Image(gym.image ?? "placeholder-image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(gym.name ?? "")
                                .font(.sport.system(.body))
                                .padding(.trailing, 10)
                                .foregroundStyle(Color.mainTextColor)
                            
                            if let types = gym.type {
                                HStack {
                                    ForEach(types.prefix(3), id: \.self) {
                                        
                                        Image(systemName: $0.image)
                                            .imageScale(.small)
                                    }
                                    if types.count > 3 {
                                        Text("+\(types.count - 3)")
                                    }
                                }
                            }
                        }
                        
                        Text(gym.description ?? "")
                            .font(.sport.system(.caption))
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    if let location = gym.location {
                        Image(systemName: "mappin")
                            .padding(EdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8))
                            .modifier(RoundedViewModifier(color: .white, opacity: 0.5))
                            .onTapGesture {
                                locationDetails = "Location: \(location.city ?? ""), \(location.district ?? "")"
                                
                                showAddress = true
                            }
                    }
                }
                .onTapGesture {
                    print("Tapped")
                    routerManager.push(.gym(.gym(gym: gym, isHomeScreen: false)))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .listStyle(PlainListStyle())
        .ignoresSafeArea(.all)
    }
    
    var sportTypeMenu: some View {
        HStack {
            Menu {
                ScrollView {
                    VStack {
                        ForEach(SportType.allCases, id: \.self) { type in
                            Button(action: {
                                //
                            }) {
                                HStack {
                                    Image(systemName: type.image)
                                    Text(type.displayName)
                                }
                            }
                        }
                    }
                }
            } label: {
                Image(systemName: "line.3.horizontal.decrease")
            }
            
            Spacer()
        }
        .font(.sport.system(.button))
        .padding(.horizontal, 5)
    }
}

#Preview {
    SearchView()
}

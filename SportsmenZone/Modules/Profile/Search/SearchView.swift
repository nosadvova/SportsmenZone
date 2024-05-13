//
//  SearchView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 09.05.2024.
//

import SwiftUI
import SportUI

struct SearchView: View {
    @State private var text: String = ""
    @State private var isLoading = false
    @State private var showAddress = false
    @State private var locationDetails = ""
    @StateObject private var viewModel = SearchViewModel()
    @EnvironmentObject private var routerManager: NavigationRouter
    
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
            }
        }
    }
}

extension SearchView {
    var gymList: some View {
        List {
            ForEach(viewModel.gyms ?? []) { gym in
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
                                print("Button tapped")
                                showAddress = true
                                
                                locationDetails = "Location: \(location.city ?? ""), \(location.district ?? "")"
                            }
                    }
                }
//                .onTapGesture {
//                    print("Tapped")
//                    routerManager.push(.gym(.gym(gym: gym)))
//                }
            }
        }
        .frame(maxWidth: .infinity)
        .listStyle(PlainListStyle())
        .ignoresSafeArea(.all)
    }
}

#Preview {
    SearchView()
}

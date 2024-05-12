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
    
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        PrimaryScreenStyle(title: "Find gym") {
            VStack {
                SearchBar(text: $text, isLoading: $isLoading)
                
                gymList
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea(.all)
            }
        }
        .modifier(LoadingViewModifier(isLoading: viewModel.requestLoadable.isLoading))
    }
}

extension SearchView {
    var gymList: some View {
        List {
            ForEach(viewModel.gyms ?? []) { gym in
                UserRow(isInteractionAllowed: true, fullName: gym.name ?? "", info: gym.description ?? "") {
                    HStack {
                        Text("Info")
                        ForEach(gym.type ?? [], id: \.self) {
                            Image(systemName: $0.image)
                        }
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    SearchView()
}

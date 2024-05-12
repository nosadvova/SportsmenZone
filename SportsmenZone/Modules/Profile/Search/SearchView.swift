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
            SearchBar(text: $text, isLoading: $isLoading)
        }
    }
}

#Preview {
    SearchView()
}

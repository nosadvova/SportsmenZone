//
//  SearchBar.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 11.05.2024.
//

import SwiftUI
import SportUI
import SportExtensions

struct SearchBar: View {
    @Binding var text: String
    
    @State var isEditing = true
    
    @Binding var isLoading: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.medium)
                        .padding(.trailing, 5)
                    
                    DefaultTextField(text: $text, placeholder: S.Search.searchGym, foregroundStyle: .black)
                        .lineLimit(2)
                        .onTapGesture {
                            withAnimation {
                                isEditing = true
                            }
                        }
                    
                    Spacer()
                    
                    if !text.isEmpty {
                        if isLoading {
                            Button(action: {
                                text = ""
                            }, label: {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            })
                        } else {
                            Button(action: {
                                text = ""
                            }, label: {
                                Image(systemName: "x.circle.fill")
                            })
                            .foregroundStyle(.black)
                        }
                    }
                }
                .padding(10)
                .background(
                    Color.inactiveButtonBackgroundColor
                        .frame(maxWidth: .infinity)
                        .clipShape(.buttonBorder))
                .padding(.leading, 10)
                
                if isEditing {
                    Button(action: {
                        text = ""
                        withAnimation(.smooth) {
                            isEditing = false
                        }
                        hideKeyboard()
                    }, label: {
                        Text("Cancel")
                            .foregroundStyle(.black)
                            .transition(.move(edge: .trailing))
                            .ignoresSafeArea()
                            .padding(.trailing, 10)
                    })
                }
            }
        }
    }
}

#Preview {
    ZStack
    {
        Color.white
            .ignoresSafeArea()
        
        SearchBar(text: .constant("Gym name"), isEditing: true, isLoading: .constant(false))
    }
    
}

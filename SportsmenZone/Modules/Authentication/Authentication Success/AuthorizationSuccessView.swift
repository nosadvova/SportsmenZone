//
//  AuthorizationSuccessView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 28.02.2024.
//

import SwiftUI
import SportUI
import Lottie

struct AuthorizationSuccessView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        PrimaryScreenStyle(title: S.AuthorizationSuccess.title, textAlignment: .center, frameAlignment: .center, description: S.AuthorizationSuccess.description) {
            VStack {
                LottieView(name: "Success", loopMode: .playOnce)
                
                Button(action: {
                    routerManager.replace(with: [])
                }, label: {
                    Text(S.finish)
                        .frame(width: 200)
                })
                .buttonStyle(RoundButtonStyle(backgroundColor: .sunsetColor, foregroundStyle: .white))
            }
        }
    }
}

#Preview {
    AuthorizationSuccessView()
}

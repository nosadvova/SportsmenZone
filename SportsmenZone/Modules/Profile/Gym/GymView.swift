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
    var body: some View {
        ShapeHeaderScreenStyle(title: "Gym", description: "Description of the gym dfhdsfjdhfjdhfj dfhdsfjdhfjdhfj dfhdsfjdhfjdhfj dfhdsfjdhfjdhfj dfhdsfjdhfjdhfj dfhdsfjdhfjdhfj dfhdsfjdhfjdhfj dfhdsfjdhfjdhfj", color: .oliveColor, content: {
            VStack {
                headButton
            }
        })
    }
}

private extension GymView {
    var headButton: some View {
        Button {
            //
        } label: {
            Text("Subscribe to the gym")
                .frame(width: 200)
        }
        .buttonStyle(RoundButtonStyle(backgroundColor: .red, foregroundStyle: .white))

    }
}

#Preview {
    GymView()
}

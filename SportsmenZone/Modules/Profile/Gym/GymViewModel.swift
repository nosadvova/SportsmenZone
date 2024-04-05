//
//  GymViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 06.03.2024.
//

import SwiftUI
import Models

final class GymViewModel: ObservableObject {
    @Published var sportsmen: [User] = MockData.users
    @Published var trainings: [Training] = MockData.trainings
}

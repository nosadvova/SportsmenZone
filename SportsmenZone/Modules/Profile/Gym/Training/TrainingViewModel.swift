//
//  TrainingViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 15.03.2024.
//

import Foundation
import Models

final class TrainingViewModel: ObservableObject {
    @Published var training: Training?
    @Published var name: String = ""
    @Published var commentary: String = ""
    @Published var trainingDay: TrainingDay?
    let isOwner: Bool
    
    init(training: Training? = nil, isOwner: Bool) {
        self.training = training
        self.isOwner = isOwner
    }
    
    var trainingDayLabel: String {
        let label: String
        
        if let trainingDay {
            label = trainingDay.displayName
        } else {
            label = S.Gym.trainingDay
        }
        return label
    }
    
    func saveTraining() {
        
    }
}

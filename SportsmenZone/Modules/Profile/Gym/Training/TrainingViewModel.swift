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
    @Published var duration: Int = 2
    @Published var time: Date = .now
    let isOwner: Bool
    
    init(training: Training? = nil, isOwner: Bool) {
        self.training = training
        self.isOwner = isOwner
        
        initialLoad()
    }
    
    private func initialLoad() {
        if let training {
            name = training.name
            commentary = training.commentary
            trainingDay = training.trainingDay
            duration = training.duration
            time = training.time
        }
    }
    
    var trainingDayLabel: String {        
        return trainingDay?.displayName ?? S.Gym.trainingDay
    }
    
    func saveTraining() {
        
    }
}

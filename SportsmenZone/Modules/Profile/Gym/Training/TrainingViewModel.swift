//
//  TrainingViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 15.03.2024.
//

import Foundation
import Models

final class TrainingViewModel: ObservableObject {
    @Published var training: Training
    
    init(training: Training) {
        self.training = training
    }
    
    func saveTraining() {
        
    }
}

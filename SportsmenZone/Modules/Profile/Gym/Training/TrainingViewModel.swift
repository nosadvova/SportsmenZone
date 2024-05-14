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
    let user: User
    let isOwner: Bool
    
    init(training: Training, user: User, isOwner: Bool) {
        self.training = training
        self.isOwner = isOwner
        self.user = user
    }
    
    func saveTraining() {
        
    }
}

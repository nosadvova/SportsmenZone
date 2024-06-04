//
//  Training.swift
//  
//
//  Created by Vova Novosad on 12.03.2024.
//

import Foundation

public enum TrainingDay: String, CaseIterable, Codable, Sendable {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
    
    public var displayName: String {
        return self.rawValue
    }
}

public struct Training: Codable, Sendable, Identifiable {
    public var id: String
    public var name: String
    public var trainingDay: TrainingDay
    public var duration: Int
    public var time: Date
    public var commentary: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case trainingDay = "training_day"
        case duration
        case time
        case commentary
    }
    
    public init(id: String, name: String, trainingDay: TrainingDay, duration: Int, time: Date, commentary: String) {
        self.id = id
        self.name = name
        self.trainingDay = trainingDay
        self.duration = duration
        self.time = time
        self.commentary = commentary
    }
}

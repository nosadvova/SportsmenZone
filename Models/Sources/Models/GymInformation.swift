//
//  File.swift
//  
//
//  Created by Vova Novosad on 22.04.2024.
//

import Foundation

public struct GymInformation: Codable {
    public var name: String
    public var description: String?
    public var location: Location
    public var trainerID: String
    public var sportsmen: [String]
    public var trainings: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, description, location
        case trainerID = "trainer_id"
        case sportsmen, trainings
    }
    
    public init(name: String, description: String? = nil, location: Location, trainerID: String, sportsmen: [String], trainings: [String]) {
        self.name = name
        self.description = description
        self.location = location
        self.trainerID = trainerID
        self.sportsmen = sportsmen
        self.trainings = trainings
    }
}

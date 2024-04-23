//
//  Gym.swift
//
//
//  Created by Vova Novosad on 22.04.2024.
//

import Foundation

public struct Location: Codable, Sendable {
    public var city: String
    public var district: String
    public var street: String
    public var buildingNumber: String
    
    enum CodingKeys: String, CodingKey {
        case city, district, street
        case buildingNumber = "building_number"
    }
    
    public init(city: String, district: String, street: String, buildingNumber: String) {
        self.city = city
        self.district = district
        self.street = street
        self.buildingNumber = buildingNumber
    }
}

public struct Gym: Codable, Sendable, Identifiable {
    public var id: String
    public var name: String
    public var description: String?
    public var location: Location
    public var trainerID: String
    public var sportsmen: [String]
    public var trainings: [String]
    public var createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name, description, location
        case trainerID = "trainer_id"
        case sportsmen, trainings
        case createdAt = "created_at"
    }
    
    public init(id: String, name: String, description: String?, location: Location, trainerID: String, sportsmen: [String], trainings: [String], createdAt: Date) {
        self.id = id
        self.name = name
        self.description = description
        self.location = location
        self.trainerID = trainerID
        self.sportsmen = sportsmen
        self.trainings = trainings
        self.createdAt = createdAt
    }
}

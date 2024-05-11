//
//  Gym.swift
//
//
//  Created by Vova Novosad on 22.04.2024.
//

import Foundation

public struct Location: Codable, Sendable {
    public var city: String?
    public var district: String?
    public var street: String?
    public var buildingNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case city, district, street
        case buildingNumber = "building_number"
    }
    
    public init(city: String? = nil, district: String? = nil, street: String? = nil, buildingNumber: String? = nil) {
        self.city = city
        self.district = district
        self.street = street
        self.buildingNumber = buildingNumber
    }
}

public enum SportType: String, CaseIterable, Codable, Sendable {
    case yoga = "Yoga"
    case boxing = "Boxing"
    case crossFit = "CrossFit"
    case weightlifting = "Weightlifting"
    case gymnastics = "Gymnastics"
    case mma = "MMA"
    case cycling = "Cycling"
    case cardio = "Cardio"
    case dance = "Dance"
    case pilates = "Pilates"
    case swimming = "Swimming"
    case basketball = "Basketball"
    
    public var displayName: String {
        return self.rawValue
    }
    
    public var image: String {
        switch self {
        case .yoga:
            "figure.yoga"
        case .boxing:
            "figure.boxing"
        case .crossFit:
            "figure.run"
        case .weightlifting:
            "figure.strengthtraining.traditional"
        case .gymnastics:
            "figure.gymnastics"
        case .mma:
            "figure.wrestling"
        case .cycling:
            "figure.outdoor.cycle"
        case .cardio:
            "figure.indoor.cycle"
        case .dance:
            "figure.dance"
        case .pilates:
            "figure.pilates"
        case .swimming:
            "figure.pool.swim"
        case .basketball:
            "figure.basketball"
        }
    }
}

public struct Gym: Codable, Sendable, Identifiable {
    public var id: String?
    public var image: String?
    public var name: String?
    public var description: String?
    public var location: Location?
    public var type: [SportType]?
    public var trainerID: String
    public var sportsmen: [String]?
    public var trainings: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name, description, location, type
        case trainerID = "trainer_id"
        case sportsmen, trainings
    }
    
    public init(id: String? = nil,
                image: String? = nil,
                name: String? = nil,
                description: String? = nil,
                location: Location? = nil,
                type: [SportType]? = nil,
                trainerID: String,
                sportsmen: [String]? = nil,
                trainings: [String]? = nil) {
        self.id = id
        self.image = image
        self.name = name
        self.description = description
        self.location = location
        self.type = type
        self.trainerID = trainerID
        self.sportsmen = sportsmen
        self.trainings = trainings
    }
}

public extension Gym {
    func copy(
    id: String? = nil,
    image: String? = nil,
    name: String? = nil,
    description: String? = nil,
    location: Location? = nil,
    type: [SportType]? = nil,
    trainerID: String? = nil,
    sportsmen: [String]? = nil,
    trainings: [String]? = nil
    ) -> Gym {
        return Gym(id: id ?? self.id,
                   image: image ?? self.image,
                   name: name ?? self.name,
                   description: description ?? self.description,
                   location: location ?? self.location,
                   type: type ?? self.type,
                   trainerID: trainerID ?? self.trainerID,
                   sportsmen: sportsmen ?? self.sportsmen,
                   trainings: trainings ?? self.trainings
        )
    }
}

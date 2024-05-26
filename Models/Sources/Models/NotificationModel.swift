//
//  NotificationModel.swift
//
//
//  Created by Vova Novosad on 26.05.2024.
//

import Foundation

public enum NotificationType: String, CaseIterable, Codable, Sendable {
    case Minor
    case Major
    
    public var image: String {
        switch self {
        case .Minor:
            "bubble.left.fill"
        case .Major:
            "exclamationmark.triangle.fill"
        }
    }
}

public struct NotificationModel: Identifiable, Codable, Sendable {
    public var id: String?
    public var gymID: String?
    public var title: String?
    public var message: String?
    public var type: NotificationType?
    public var createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case gymID = "gym_id"
        case title
        case message
        case type
        case createdAt = "created_at"
    }
    
    public init(id: String? = nil,
                gymID: String? = nil,
                title: String? = nil,
                message: String? = nil,
                type: NotificationType? = nil,
                createdAt: Date? = nil)
    {
        self.id = id
        self.gymID = gymID
        self.title = title
        self.message = message
        self.type = type
        self.createdAt = createdAt
    }
}

extension NotificationModel {
    func copy(
        id: String? = nil,
        gymID: String? = nil,
        title: String? = nil,
        message: String? = nil,
        type: NotificationType? = nil,
        createdAt: Date? = nil
    ) -> NotificationModel {
        return NotificationModel(
            id: id ?? self.id,
            gymID: gymID ?? self.gymID,
            title: title ?? self.title,
            message: message ?? self.message,
            type: type ?? self.type,
            createdAt: createdAt ?? self.createdAt
        )
    }
}

//
//  Encodable + Extension.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 30.03.2024.
//

import Foundation

extension Encodable {
    func requestBody() -> Data? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .withoutEscapingSlashes
        
        return try? jsonEncoder.encode(self)
    }
}

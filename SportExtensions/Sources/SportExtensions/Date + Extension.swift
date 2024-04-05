//
//  File.swift
//  
//
//  Created by Vova Novosad on 17.03.2024.
//

import Foundation

public extension Date {
    func trainingTime() -> String {
        self.formatted(date: .omitted, time: .shortened)
    }
}

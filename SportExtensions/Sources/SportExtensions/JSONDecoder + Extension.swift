//
//  JSONDecoder + Extension.swift
//  
//
//  Created by Vova Novosad on 17.04.2024.
//

import Foundation

public extension DateFormatter {
//    static let rfc3339: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        formatter.calendar = Calendar(identifier: .gregorian)
//        return formatter
//    }()
    
    static let rfc3339: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            return formatter
        }()
}


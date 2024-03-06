//
//  String + Extension.swift
//  
//
//  Created by Vova Novosad on 23.02.2024.
//

import Foundation

public extension String {
    var isEmailValid: Bool {
        let emailFormat = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    var isPasswordValid: Bool {
        let passwordFormat = "^[A-Za-z0-9/\\-*_#%!&()\\.\\,{}\\[\\]<>`~₴$^+=№;:|?@]{6,18}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: self)
    }
}

//
//  NavigationIcon.swift
//  
//
//  Created by Vova Novosad on 21.02.2024.
//

import SwiftUI

public enum NavigationIcon {
    case close
    case back
    case forward
    
    var image: Image? {
        switch self {
        case .close:
            Image(systemName: "xmark")
        case .back:
            Image(systemName: "arrow.backward")
        case .forward:
            Image(systemName: "arrow.forward")
        }
    }
}

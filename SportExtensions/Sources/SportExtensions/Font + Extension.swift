//
//  Font + Extension.swift
//
//
//  Created by Vova Novosad on 22.02.2024.
//

import SwiftUI

public extension Font {
    static var sport: FontStyle = .init()
}

public struct FontStyle {
    public func custom(_ fontName: Lato, size: CGFloat) -> Font {
        return Font.custom(fontName.rawValue, size: size)
    }
    
    public func system(_ customStyle: CustomTextStyle) -> Font {
        let guide = styleGuide(customStyle)
        return Font.custom(guide.fontName, size: guide.size)
    }
    
    private func styleGuide(_ customTextStyle: CustomTextStyle) -> (fontName: String, size: CGFloat) {
        var fontName: Lato = Lato.regular
        var fontSize: CGFloat = 16
        
        switch customTextStyle {
        case .button:
            fontName = .bold
            fontSize = 18
        case .textField:
            fontName = .regular
            fontSize = 18
        case .body:
            fontName = .regular
            fontSize = 16
        case .caption:
            fontName = .regular
            fontSize = 15
        case .description:
            fontName = .light
            fontSize = 14
        case .title:
            fontName = .regular
            fontSize = 24
        case .title2:
            fontName = .regular
            fontSize = 18
        case .largeTitle:
            fontName = .bold
            fontSize = 30
        }
        
        return (fontName: fontName.rawValue, size: fontSize)
    }
}

public enum CustomTextStyle {
    case button
    case textField
    case body
    case caption
    case description
    case title
    case title2
    case largeTitle
}

public enum Lato: String, CaseIterable {
    case regular = "Lato-Regular"
    case italic = "Lato-Italic"
    case bold = "Lato-Bold"
    case black = "Lato-Black"
    case blackItalic = "Lato-BlackItalic"
    case light = "Lato-Light"
    case thin = "Lato-Thin"
}

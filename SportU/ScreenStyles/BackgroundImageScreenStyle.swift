//
//  BackgroundImageScreenStyle.swift
//  
//
//  Created by Vova Novosad on 21.02.2024.
//

import SwiftUI

public struct BackgroundImageScreenStyle<Content, BackgroundView>: View where Content: View, BackgroundView: View {
    private let content: () -> Content
    private let backgroundImage: () -> BackgroundView
    private let dismissIcon: NavigationIcon?
    private let title: String

    public init(
      headerImage: @autoclosure @escaping () -> BackgroundView,
      dismissIcon: NavigationIcon? = nil,
      title: String,
      @ViewBuilder content: @escaping () -> Content
    ) {
      self.backgroundImage = headerImage
      self.dismissIcon = dismissIcon
      self.title = title
      self.content = content
    }
    
    public var body: some View {
        ZStack {
//            if let headerImage = headerImage() as? Image {
//              headerImage
//                .resizable()
//                .scaledToFit()
//            } else {
//              headerImage()
//            }
            
            backgroundImage()
            
            VStack {
                
            }
        }
    }
}

//#Preview {
//    BackgroundImageScreenStyle()
//}

//
//  LottieView.swift
//
//
//  Created by Vova Novosad on 28.02.2024.
//

import SwiftUI
import Lottie

public struct LottieView: UIViewRepresentable {
    let name: String
    let loopMode: LottieLoopMode
    let animationSpeed: CGFloat
    let mit = 5
    
    public init(
        name: String,
        loopMode: LottieLoopMode = .loop,
        animationSpeed: CGFloat = 1
    ) {
        self.name = name
        self.loopMode = loopMode
        self.animationSpeed = animationSpeed
    }
    
    public func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView(name: name, bundle: .main)
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        animationView.play()
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {
        //
    }
}


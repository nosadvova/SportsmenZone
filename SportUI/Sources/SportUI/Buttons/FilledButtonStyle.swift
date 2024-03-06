//
//  FilledButtonStyle.swift
//  
//
//  Created by Vova Novosad on 18.02.2024.
//

import SwiftUI

struct FilledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        //
    }
}

#Preview {
    Button {
        //
    } label: {
        Text("Text")
    }
    .buttonStyle(FilledButtonStyle())
}

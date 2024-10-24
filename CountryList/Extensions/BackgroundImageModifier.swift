//
//  BackgroundImageModifier.swift
//  CountryList
//
//  Created on 2024-10-18.
//

import SwiftUI

struct BackgroundImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                Image("bgImage")
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 1)
                    .edgesIgnoringSafeArea(.all)
                    .colorMultiply(.colorWhite)
            )
    }
}

extension View {
    func withBackground() -> some View {
        self.modifier(BackgroundImageModifier())
    }
}

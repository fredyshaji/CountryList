//
//  SplashView.swift
//  CountryList
//
//  Created on 2024-10-24.
//


import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var opacity = 0.0

    var body: some View {
        VStack {
            if isActive {
                HomeView()
            } else {
                VStack {
                    Image(systemName: "globe")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.accentColor)
                    Text(CommonStrings.CountryList.appTitle)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                }
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.5)) {
                        opacity = 1.0 // Fade in the content
                    }
                }
            }
        }
        .onAppear {
            // Start a timer to transition to the HomeView
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true // Navigate to HomeView
                }
            }
        }
    }
}

#Preview {
    SplashView()
}

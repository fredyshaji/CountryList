//
//  HomeView.swift
//  CountryList
//
//  Created by p901nyy on 2024-10-17.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        ZStack {
            // Main content
            TabView {
                RegionView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                SearchView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
            .accentColor(.indigo)
            
            // Gradient or shadow above tab bar
            VStack {
                Spacer()

                LinearGradient(
                    gradient: Gradient(colors: [Color.white.opacity(0.1), Color.gray.opacity(0.6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 100) // Adjust height to your liking
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5) // Shadow for depth
                .allowsHitTesting(false)
                
            }
            .edgesIgnoringSafeArea(.bottom) // Ignore safe area to ensure it aligns with tab bar
        }
    }
}
#Preview {
    HomeView()
}

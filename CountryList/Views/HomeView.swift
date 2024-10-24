//
//  HomeView.swift
//  CountryList
//
//  Created on 2024-10-17.
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
                        Text(CommonStrings.CountryList.home)
                    }
                SearchView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text(CommonStrings.CountryList.search)
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text(CommonStrings.CountryList.profile)
                    }
            }
            .accentColor(.accentColor)
            
            // Gradient or shadow above tab bar
            VStack {
                Spacer()

                LinearGradient(
                    gradient: Gradient(colors: [Color.colorWhite.opacity(0.1), Color.gray.opacity(0.6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 100)
                .shadow(color: Color.colorBlack.opacity(0.1), radius: 10, x: 0, y: -5) // Shadow for depth
                .allowsHitTesting(false)
                
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
#Preview {
    HomeView()
}

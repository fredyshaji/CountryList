//
//  ContentView 2.swift
//  CountryList
//
//  Created by p901nyy on 2024-10-17.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: HomeViewModel // Accept HomeViewModel instance
    
    var body: some View {
        NavigationView { // Wrap in a NavigationView
            VStack {
                // Search Bar
                TextField("Search for a country...", text: $viewModel.searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // List of filtered countries
                List {
                    ForEach(viewModel.filteredCountries, id: \.id) { country in
                        NavigationLink(destination: CountryDetailView(country: country)) { // Navigate to CountryDetailsView
                            HStack {
                                AsyncImage(url: URL(string: country.flags.png)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 30)
                                } placeholder: {
                                    Color.gray
                                        .frame(width: 40, height: 30)
                                }
                                Text(country.name.common)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .withBackground()
            .navigationTitle("Search Countries")
        }
    }
}

#Preview {
    SearchView(viewModel: HomeViewModel())
}

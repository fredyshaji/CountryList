//
//  ContentView 2.swift
//  CountryList
//
//  Created on 2024-10-17.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: HomeViewModel // Accept HomeViewModel instance
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Text(CommonStrings.CountryList.searchCountryTitle)
                        .font(.largeTitle)
                        .bold()
                        .padding([.leading, .top])
                        .foregroundColor(.accentColor)
                    // Search Bar
                    TextField(CommonStrings.CountryList.searchForCountry, text: $viewModel.searchText)
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
                                            .scaledToFill()
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(.black, lineWidth: 0.5))
                                    } placeholder: {
                                        Image(systemName: "flag.circle")
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(.black, lineWidth: 0.5))
                                    }
                                    Text(country.name.common)
                                }
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                    .cornerRadius(10)
                    .padding()
                }
                
            }
            .withBackground()
        }
    }
}

#Preview {
    SearchView(viewModel: HomeViewModel())
}

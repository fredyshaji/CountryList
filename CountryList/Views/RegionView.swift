//
//  RegionView.swift
//  CountryList
//
//  Created on 2024-10-18.
//

import SwiftUI

struct RegionView: View {
    @ObservedObject var viewModel: HomeViewModel
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Text("Explore Countries")
                        .font(.largeTitle)
                        .bold()
                        .padding([.leading, .top])
                        .foregroundColor(.indigo)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(Continent.allCases) { continent in
                                Button(action: {
                                    viewModel.selectedContinent = continent
                                    viewModel.filterCountriesByContinent() // Filter countries
                                }) {
                                    ContinentCard(
                                        continent: continent,
                                        isSelected: continent == viewModel.selectedContinent )
                                }
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    
                    Text("Countries in \(viewModel.selectedContinent.rawValue)")
                        .font(.title)
                        .bold()
                        .padding([.leading, .top])
                        .foregroundColor(.indigo)
                    
                    if viewModel.isLoading {
                        ProgressView("Loading countries...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity) // Take up all available space
                            .background(Color.gray.opacity(0.2))
                    } else {
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        } else {
                            ScrollView {
                                LazyVGrid(columns: columns, spacing: 20) {
                                    ForEach(viewModel.countries) { country in
                                        CountryCard(country: country)
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .withBackground()
            .onAppear {
                viewModel.fetchCountries()  // Fetch countries when the view appears
            }
        }
    }
}

#Preview {
    RegionView(viewModel: HomeViewModel())
}


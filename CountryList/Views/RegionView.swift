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
                    Text(CommonStrings.CountryList.exploreCountries)
                        .font(.largeTitle)
                        .bold()
                        .padding([.leading, .top])
                        .foregroundColor(.accentColor)
                    
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
                    
                    Text("\(CommonStrings.CountryList.countriesIn) \(viewModel.selectedContinent.rawValue)")
                        .font(.title)
                        .bold()
                        .padding([.leading])
                        .foregroundColor(.accentColor)
                    
                    if viewModel.isLoading {
                        ProgressView(CommonStrings.CountryList.loadingCountries)
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
                                LazyVGrid(columns: columns,
                                          spacing: 5
                                ) {
                                    ForEach(viewModel.countries) { country in
                                        CountryCard(country: country)
                                    }
                                }
                                .padding()
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


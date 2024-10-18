//
//  HomeVM.swift
//  CountryList
//
//  Created by p901nyy on 2024-10-18.
//

import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var countries: CountryList = []
    @Published var isLoading: Bool = false // Property for loading state
    @Published var errorMessage: String? = nil // Store error message
    @Published var hasFetchedCountries = false
    @Published var selectedContinent: Continent = .africa // Property for selected continent
    @Published var searchText = "" // Added for search functionality

    private var allCountries: CountryList = [] // Store all countries initially
    private var cancellables = Set<AnyCancellable>()
    var loader = CountryLoader() // Initialize the loader
    
    // This function will use the loader to fetch the countries
    func fetchCountries() {
        guard !hasFetchedCountries, !isLoading else { return } // Prevent fetching if already fetched
        isLoading = true
        print("Starting to fetch countries...")

        loader.fetchCountries()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        self?.errorMessage = "Invalid URL."
                    case .decodingError:
                        self?.errorMessage = "Error decoding data."
                    case .networkError(let networkError):
                        self?.errorMessage = "Network error: \(networkError.localizedDescription)"
                    }
                case .finished:
                    print("Finished fetching countries")
                }
            }, receiveValue: { [weak self] countries in
                guard let self else { return }
                
                // Create a mapping of cca3 to official country names
                let cca3ToOfficialName = Dictionary(uniqueKeysWithValues: countries.map { ($0.cca3, $0.name.official) })
                
                // Update allCountries and map borders to their official names
                self.allCountries = countries.map { country in
                    var modifiedCountry = country
                    modifiedCountry.borders = country.borders?.compactMap { borderCode in
                        cca3ToOfficialName[borderCode] // Replace border CCA3 with official names
                    }
                    return modifiedCountry
                }.sorted { $0.name.common < $1.name.common }
                
                hasFetchedCountries = true
                filterCountriesByContinent()
                print("Fetched \(countries.count) countries.")
            })
            .store(in: &cancellables)
    }

    // Method to filter countries by selected continent
    func filterCountriesByContinent() {
        countries = allCountries.filter { $0.continents.contains(selectedContinent) }
    }
    
    // Added method to filter countries based on search text
    var filteredCountries: CountryList {
        if searchText.isEmpty {
            return allCountries
        } else {
            return allCountries.filter { country in
                country.name.common.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

//
//  MockCountryLoader.swift
//  CountryList
//
//  Created by p901nyy on 2024-10-18.
//

import Foundation
import Combine
@testable import CountryList

class MockCountryLoader: CountryLoader {
    var shouldReturnError = false // Flag to control error response
    
    override func fetchCountries() -> AnyPublisher<CountryList, CountryLoaderError> {
        // Predefined mock data
        let mockCountries: CountryList = [
            CountryItem(name: Name(common: "Nigeria", official: "Federal Republic of Nigeria", nativeName: [:]),
                        tld: [".ng"],
                        cca2: "NG",
                        ccn3: "566",
                        cca3: "NGA",
                        independent: true,
                        status: .officiallyAssigned,
                        unMember: true,
                        currencies: ["NGN": Currency(name: "Naira", symbol: "₦")],
                        idd: Idd(root: "+234", suffixes: ["0"]),
                        capital: ["Abuja"],
                        altSpellings: ["NG", "Naija"],
                        region: .africa,
                        languages: ["eng": "English"],
                        translations: [:],
                        latlng: [9.082, 8.6753],
                        landlocked: false,
                        area: 923768,
                        demonyms: nil,
                        flag: "🇳🇬",
                        maps: Maps(googleMaps: "", openStreetMaps: ""),
                        population: 206139589,
                        car: Car(signs: ["N"], side: .sideRight),
                        timezones: ["UTC+1"],
                        continents: [.africa],
                        flags: Flags(png: "", svg: "", alt: ""),
                        coatOfArms: CoatOfArms(png: nil, svg: nil),
                        startOfWeek: .monday,
                        capitalInfo: CapitalInfo(latlng: nil),
                        cioc: "NGA",
                        subregion: "Western Africa",
                        fifa: "NGA",
                        borders: nil,
                        gini: nil,
                        postalCode: nil),
            CountryItem(name: Name(common: "Canada", official: "Canada", nativeName: [:]),
                        tld: [".ca"],
                        cca2: "CA",
                        ccn3: "124",
                        cca3: "CAN",
                        independent: true,
                        status: .officiallyAssigned,
                        unMember: true,
                        currencies: ["CAD": Currency(name: "Canadian Dollar", symbol: "$")],
                        idd: Idd(root: "+1", suffixes: [""]),
                        capital: ["Ottawa"],
                        altSpellings: ["CA"],
                        region: .americas,
                        languages: ["eng": "English", "fra": "French"],
                        translations: [:],
                        latlng: [56.1304, -106.3468],
                        landlocked: false,
                        area: 9984670,
                        demonyms: nil,
                        flag: "🇨🇦",
                        maps: Maps(googleMaps: "", openStreetMaps: ""),
                        population: 37742154,
                        car: Car(signs: ["N"], side: .sideRight),
                        timezones: ["UTC-3:30", "UTC-8"],
                        continents: [.northAmerica],
                        flags: Flags(png: "", svg: "", alt: ""),
                        coatOfArms: CoatOfArms(png: nil, svg: nil),
                        startOfWeek: .monday,
                        capitalInfo: CapitalInfo(latlng: nil),
                        cioc: "CAN",
                        subregion: "North America",
                        fifa: "CAN",
                        borders: nil,
                        gini: nil,
                        postalCode: nil)
        ]
        
        // Return an error if the flag is set
        if shouldReturnError {
            return Fail(error: CountryLoaderError.networkError(NSError(domain: "", code: -1, userInfo: nil)))
                .eraseToAnyPublisher()
        }
        
        // Simulate a successful network call with a delay
        return Just(mockCountries)
            .setFailureType(to: CountryLoaderError.self)
            .delay(for: .seconds(0.5), scheduler: RunLoop.main) // Simulate network delay
            .eraseToAnyPublisher()
    }
}

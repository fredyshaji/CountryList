//
//  CountryLoader.swift
//  CountryList
//
//  Created 2024-10-18.
//

import Foundation
import Combine

enum CountryLoaderError: Error {
    case invalidURL
    case decodingError
    case networkError(Error)
}

class CountryLoader {
    func fetchCountries() -> AnyPublisher<CountryList, CountryLoaderError> {
        // Safely unwrap the URL
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
            return Fail(error: CountryLoaderError.invalidURL).eraseToAnyPublisher()
        }
        
        // Create a URLSession with a configuration
        let session = URLSession.shared
        
        return session.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CountryList.self, decoder: JSONDecoder())
            .mapError { error -> CountryLoaderError in
                // Handle decoding and network errors
                if error is DecodingError {
                    return .decodingError
                } else {
                    return .networkError(error)
                }
            }
            .eraseToAnyPublisher()
    }
}

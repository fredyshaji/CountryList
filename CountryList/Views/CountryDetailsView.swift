//
//  CountryDetailsView.swift
//  CountryList
//
//  Created on 2024-10-17.
//

import SwiftUI
import MapKit

struct CountryDetailView: View {
    let country: CountryItem
    
    // State variable to hold the map position
    @State private var cameraPosition: MapCameraPosition
    
    init(country: CountryItem) {
        self.country = country
        // Initialize the map region with the country's latitude and longitude
        let latitude = country.latlng.first ?? 0
        let longitude = country.latlng.last ?? 0
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        _cameraPosition = State(initialValue: MapCameraPosition.region(region))
    }
    
    var body: some View {
        ZStack {
            
            // Background map
            Map(position: $cameraPosition)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.5) // Make map slightly transparent for better readability
            
            // Scrollable content
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Country Name
                    Text(country.name.common)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.top)
                        .padding(.horizontal)
                        .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2) // Added shadow
                    
                    // National Symbols Title
                    Text(CommonStrings.CountryList.nationalSymbols)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                        .padding()
                        .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2)
                    
                    // Flag and Coat of Arms
                    HStack(spacing: 20) {
                        // Flag
                        countrySymbolView(imageURL: country.flags.png,
                                          title: CommonStrings.CountryList.flag)
                        
                        // Coat of Arms
                        if let imageString = country.coatOfArms.png, let coatOfArmsURL = URL(string: imageString) {
                            countrySymbolView(imageURL: coatOfArmsURL.absoluteString,
                                              title: CommonStrings.CountryList.coatOfArms)
                        }
                    }
                    .padding(.horizontal)
                    
                    
                    // Country Information Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Country Information")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                            .padding(.bottom, 10)
                        
                        informationCard(title: CommonStrings.CountryList.officialName,
                                        value: country.name.official)
                        informationCard(title: CommonStrings.CountryList.commonName,
                                        value: country.name.common)
                        informationCard(title: CommonStrings.CountryList.nativeName,
                                        value: country.name.nativeName?.values.first?.common ?? "N/A")
                        informationCard(title: CommonStrings.CountryList.continent, value: country.continents.map { $0.rawValue }.joined(separator: ", "))
                        
                        if let currency = country.currencies?.first?.value {
                            informationCard(title: CommonStrings.CountryList.currency, value: "\(currency.name) (\(currency.symbol))")
                        }
                        
                        if let demonyms = country.demonyms {
                            informationCard(title: CommonStrings.CountryList.demonymEnglish,
                                            value: demonyms.eng.f)
                            if let fra = demonyms.fra?.f {
                                informationCard(title: CommonStrings.CountryList.demonymFrench,
                                                value: fra)
                            }
                        }
                        
                        informationCard(title: CommonStrings.CountryList.latitude,
                                        value: "\(country.latlng.first ?? 0)")
                        informationCard(title: CommonStrings.CountryList.longitude,
                                        value: "\(country.latlng.last ?? 0)")
                        
                        if let borders = country.borders, !borders.isEmpty {
                            informationCard(title: CommonStrings.CountryList.borders,
                                            value: borders.joined(separator: ", "))
                        }
                    }
                    .padding()
                    
                    // Google Maps Link
                    if let mapsURL = URL(string: country.maps.googleMaps) {
                        Link(CommonStrings.CountryList.viewOnGmaps, destination: mapsURL)
                            .padding()
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                }
                .padding()
                .cornerRadius(15)
                .padding(.horizontal)
            }
            .background(Color.gray.opacity(0.3))
        }
        .withBackground()
        .navigationTitle(country.name.common)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Helper function to create a country symbol view
    @ViewBuilder
    private func countrySymbolView(imageURL: String, title: String) -> some View {
        VStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 100)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
                    .background(Color.white.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                Color.blue
                    .frame(width: 150, height: 100)
                    .cornerRadius(10)
            }
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2)
        }
    }

    // Helper function to create information card
    @ViewBuilder
    func informationCard(title: String, value: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.black)
            Text(value)
                .font(.subheadline)
                .fontWeight(.regular)
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}




#Preview {
    CountryDetailView(
        country: CountryItem(
            name: Name(
                common: "South Georgia",
                official: "South Georgia and the South Sandwich Islands",
                nativeName: ["eng": Translation(official: "South Georgia and the South Sandwich Islands", common: "South Georgia")]
            ),
            tld: [".gs"],
            cca2: "GS",
            ccn3: "239",
            cca3: "SGS",
            independent: false,
            status: .officiallyAssigned,
            unMember: false,
            currencies: ["SHP": Currency(name: "Saint Helena pound", symbol: "Â£")],
            idd: Idd(root: "+5", suffixes: ["00"]),
            capital: ["King Edward Point"],
            altSpellings: ["GS", "South Georgia and the South Sandwich Islands"],
            region: .antarctic,
            languages: ["eng": "English"],
            translations: [ "ara": Translation(official: "Ø¬ÙˆØ±Ø¬ÙŠØ§ Ø§Ù„Ø¬Ù†ÙˆØ¨ÙŠØ© ÙˆØ¬Ø²Ø± Ø³Ø§Ù†Ø¯ÙˆØªØ´ Ø§Ù„Ø¬Ù†ÙˆØ¨ÙŠØ©", common: "Ø¬ÙˆØ±Ø¬ÙŠØ§ Ø§Ù„Ø¬Ù†ÙˆØ¨ÙŠØ©"),
                            "bre": Translation(official: "Georgia ar Su hag Inizi Sandwich ar Su", common: "Georgia ar Su hag Inizi Sandwich ar Su"),
                            "swe": Translation(official: "Sydgeorgien", common: "Sydgeorgien")],
            latlng: [20.7572855,72.1093036],
            landlocked: false,
            area: 3903.0,
            demonyms: Demonyms(
                eng: Eng(f: "South Georgian South Sandwich Islander",
                         m: "South Georgian South Sandwich Islander"),
                fra: nil ),
            flag: "",
            maps: Maps(googleMaps: "https://goo.gl/maps/mJzdaBwKBbm2B81q9",
                       openStreetMaps: "https://www.openstreetmap.org/relation/1983629"),
            population: 30,
            car: Car(signs: [], side: .sideRight),
            timezones: ["UTC-02:00"],
            continents: [.antarctica],
            flags: Flags(png: "https://flagcdn.com/w320/gs.png",
                         svg: "https://flagcdn.com/gs.svg",
                         alt: ""),
            coatOfArms: CoatOfArms(png: "", svg: ""),
            startOfWeek: .monday,
            capitalInfo: CapitalInfo(latlng: [20.7572855,72.1093036]),
            cioc: "",
            subregion: "",
            fifa: "",
            borders: [],
            gini: [:],
            postalCode: PostalCode(format: "", regex: "")
        )
    )
}

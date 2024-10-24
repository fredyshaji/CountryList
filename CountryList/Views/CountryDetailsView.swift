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
    let viewModel: CountryDetailVM
    
    // State variable to hold the map position
    @State private var cameraPosition: MapCameraPosition
    
    init(country: CountryItem) {
        self.country = country
        viewModel = CountryDetailVM(country: country)
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
                .opacity(0.5)

            // Scrollable content
            ScrollView {
                VStack(alignment: .leading) {

                    // National Symbols Title
                    Text(CommonStrings.CountryList.nationalSymbols)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                        .shadow(color: .white, radius: 5, x: 1, y: 2)

                    // Flag and Coat of Arms
                    HStack {
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

                    if let flagInfo = country.flags.alt {
                        informationCard(title: "", value: flagInfo)
                    }

                    // Country Information Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text(CommonStrings.CountryList.countryInfo)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top, 10)
                            .padding(.leading, 10)
                            .shadow(color: .white, radius: 5, x: 1, y: 2)

                        informationCard(title: CommonStrings.CountryList.officialName,
                                        value: country.name.official)
                        if let nativeName = country.name.nativeName?.values.first?.official {
                            informationCard(title: CommonStrings.CountryList.nativeName,
                                            value: nativeName)
                        }

                        if let capital = country.capital {
                            informationCard(title: CommonStrings.CountryList.capital,
                                            value: capital.map { $0 }.joined(separator: ", "))
                        }

                        let continentCardDetails = viewModel.getContinentCardText()
                        informationCard(
                            title: continentCardDetails.0,
                            value: continentCardDetails.1)

                        if let demonyms = country.demonyms {
                            informationCard(title: CommonStrings.CountryList.demonymEnglish,
                                            value: demonyms.eng.f)
                        }

                        if let currency = country.currencies?.first?.value {
                            informationCard(title: CommonStrings.CountryList.currency, value: "\(currency.name) (\(currency.symbol))")
                        }
                        informationCard(title: CommonStrings.CountryList.area,
                                        value: "\(country.area) sq.km")
                        informationCard(title: CommonStrings.CountryList.population,
                                        value: country.population.formatted(.number.notation(.compactName)))

                        let latLongcardText = viewModel.getLatLongCardText()
                        informationCard(title: latLongcardText.0,
                                        value: latLongcardText.1)

                        if let languages = country.languages {
                            informationCard(title: CommonStrings.CountryList.languages,
                                            value: languages.map { $0.value }
                                .joined(separator: ", "))
                        }
                        
                        if let borders = country.borders, !borders.isEmpty {
                            informationCard(title: CommonStrings.CountryList.borders,
                                            value: borders.joined(separator: ", "))
                        }
                        informationCard(title: CommonStrings.CountryList.timeZones,
                                        value: viewModel
                            .formatTimeZoneText())
                    }
                    
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
                .cornerRadius(15)
                .padding(.leading, 10)
            }
            .background(Color.gray.opacity(0.3))
        }
        .withBackground()
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.large)
        .navigationTitle(country.name.common)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
    
    // Helper function to create a country symbol view
    @ViewBuilder
    private func countrySymbolView(imageURL: String, title: String) -> some View {
        VStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 80)
                    .shadow(radius: 5)
                    .background(.clear)
            } placeholder: {
                Image(systemName: "photo")
                    .frame(width: 120, height: 80)
                    .foregroundStyle(.gray)
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
                .font(.headline)
                .fontWeight(.regular)
                .foregroundColor(.black)
        }
        .padding()
        .background(Color.white.opacity(0.3))
        .cornerRadius(12)
        .clipShape(Rectangle())
        .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.black, lineWidth: 0.2)
            )
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

//
//  CountryCard.swift
//  CountryList
//
//  Created by p901nyy on 2024-10-18.
//

import SwiftUI

struct CountryCard: View {
    let country: CountryItem

    var body: some View {
        NavigationLink(destination: CountryDetailView(country: country)) {
            VStack {
                AsyncImage(url: URL(string: country.flags.png)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.indigo // Placeholder while loading
                }
                .frame(width: 100, height: 70)
                .cornerRadius(10)

                Text(country.name.official)
                    .font(.headline)
                    .padding(.top, 5)
                    .foregroundStyle(.indigo)
                    .minimumScaleFactor(0.4)
            }
            .frame(width: UIScreen.screenWidth/3, height: 150)
            .shadow(radius: 5)
            .padding(.horizontal, 8)
        }
    }
}

#Preview {
    CountryCard(
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
            latlng: [-54.5, -37.0],
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
            capitalInfo: CapitalInfo(latlng: [-54.28, -36.5]),
            cioc: "",
            subregion: "",
            fifa: "",
            borders: [],
            gini: [:],
            postalCode: PostalCode(format: "", regex: "")
        )
    )
}

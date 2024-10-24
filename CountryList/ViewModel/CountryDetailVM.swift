//
//  CountryDetailVM.swift
//  CountryList
//
//  Created by p901nyy on 2024-10-24.
//

class CountryDetailVM {
    private typealias StringsKey = CommonStrings.CountryList
    let country: CountryItem

    init(country: CountryItem) {
        self.country = country
    }
    
    func getContinentCardText() -> (String, String) {
        let title = StringsKey.continent + " / " + StringsKey.region + " / " + StringsKey.subRegion
        var value = country.continents.map { $0.rawValue }.joined(separator: ", ")
        value += " / " + country.region.rawValue + " / " + (country.subregion ?? "--")
        return(title, value)
    }

    func getLatLongCardText() -> (String, String) {
        let title = StringsKey.latitude + " / " + StringsKey.longitude
        let value = "\(country.latlng.first ?? 0) / \(country.latlng.last ?? 0)"
        return(title, value)
    }

    func formatTimeZoneText()-> String {
        country.timezones
            .map { $0.replacingOccurrences(of: "UTC", with: "") }
            .joined(separator: ", ")
    }
}

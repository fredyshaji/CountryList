//
//  ContinentCard.swift
//  CountryList
//
//  Created on 2024-10-18.
//

import SwiftUI

// View for a Single Region Card
struct ContinentCard: View {
    let continent: Continent
    var isSelected: Bool // New property to check if it's selected

    var body: some View {
        VStack {
            Image(systemName: continent.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .background(isSelected ? .white : Color(.systemGray6)) // Highlight color when selected
                .clipShape(Circle())
                .overlay(Circle().stroke(isSelected ? .white : .clear, lineWidth: 2)) // Highlight border
                .foregroundColor(isSelected ? .blue : .gray)
                .padding(.top, 8)


            Text(continent.rawValue)
                .font(.headline)
                .padding(.top, 5)
                .foregroundColor(isSelected ? .blue : .gray)
                .minimumScaleFactor(0.6)
            Spacer()
        }
        .frame(width: 100, height: 135)
        .shadow(radius: 5)
    }
}

#Preview {
    ContinentCard(continent: .southAmerica, isSelected: false)
}

//
//  ContinentCard.swift
//  CountryList
//
//  Created by p901nyy on 2024-10-18.
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
                .frame(width: 70, height: 70)
                .background(isSelected ? Color.blue : Color(.systemGray6)) // Highlight color when selected
                .clipShape(Circle())
                .overlay(Circle().stroke(isSelected ? Color.white : Color.clear, lineWidth: 2)) // Highlight border
                .foregroundColor(.cyan)

            Text(continent.rawValue)
                .font(.headline)
                .padding(.top, 5)
                .foregroundColor(.indigo)
                .minimumScaleFactor(0.6)
        }
        .frame(width: 90, height: 120)
        .shadow(radius: 5)
        .padding(.horizontal, 8)
    }
}

#Preview {
    ContinentCard(continent: .africa, isSelected: false)
}

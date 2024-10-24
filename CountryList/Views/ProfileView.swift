//
//  ProfileView.swift
//  CountryList
//
//  Created on 2024-10-18.
//

import SwiftUI

struct ProfileView: View {
    @State private var username = "John Doe"
    @State private var email = "john@example.com"
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                // Title
                Text(CommonStrings.CountryList.profile)
                    .font(.largeTitle)
                    .bold()
                    .padding([.leading, .top])
                    .foregroundColor(.accentColor)
                
                // User Information
                VStack(alignment: .center, spacing: 16) {
                    // Profile Image
                    Image(systemName: "person.circle.fill") // Default profile icon
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .padding()
                        .overlay(Circle().stroke(.colorBlack, lineWidth: 1))

                    VStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text(CommonStrings.CountryList.name)
                                .font(.footnote)
                            TextField(CommonStrings.CountryList.name, text: $username)
                                .padding(.bottom, 10)
                            Text(CommonStrings.CountryList.email)
                                .font(.footnote)
                            TextField(CommonStrings.CountryList.email, text: $email)
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(20)
                    .frame(width: UIScreen.screenWidth - 40)
                    .foregroundStyle(.secondary)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 12)
                        .stroke(.colorBlack, lineWidth: 0.5))
                    
                    // Displaying Name and Email
                    VStack(alignment: .center) {
                        Text("\(CommonStrings.CountryList.name): \(username)")
                            .font(.headline)
                            .foregroundColor(.colorBlack)
                            .padding(.vertical, 5)
                        
                        Text("\(CommonStrings.CountryList.email): \(email)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.colorWhite.opacity(0.5))
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                .padding()
                Spacer()
            }
        }
        .withBackground()
    }
}

#Preview {
    ProfileView()
}

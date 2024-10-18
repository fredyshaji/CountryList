//
//  ProfileView.swift
//  CountryList
//
//  Created by p901nyy on 2024-10-18.
//

import SwiftUI

struct ProfileView: View {
    @State private var username = "John Doe"
    @State private var email = "john@example.com"

    var body: some View {
        ZStack {
            VStack {
                // Title
                Text("Profile")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.indigo)
                    .padding()

                // Profile Image
                Image(systemName: "person.circle.fill") // Default profile icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray) // Change color as needed
                    .padding()

                // User Information
                VStack(alignment: .leading, spacing: 16) {
                    // Username
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                    
                    // Email
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)

                    // Displaying Name and Email
                    VStack(alignment: .leading) {
                        Text("Name: \(username)")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.vertical, 5)

                        Text("Email: \(email)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                .padding()
            }
            .padding()
            .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea()) // Background color for the view
        }
    }
}

#Preview {
    ProfileView()
}

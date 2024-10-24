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
            VStack {
                // Title
                Text("Profile")
                    .font(.largeTitle)
                    .bold()
                    .padding([.leading, .top])
                    .foregroundColor(.indigo)

                // Profile Image
                Image(systemName: "person.circle.fill") // Default profile icon
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray) // Change color as needed
                    .padding()
                
                // User Information
                VStack(alignment: .center, spacing: 16) {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("Name")
                                .font(.footnote)
                            TextField("Name", text: $username)
                                .padding(.bottom, 10)
                            Text("Email")
                                .font(.footnote)
                            TextField("Email", text: $email)
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(20)
                    .frame(width: UIScreen.screenWidth - 40)
                    .foregroundStyle(.secondary)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    
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
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                .padding()
                Spacer()
            }
            .padding()
        }
        .withBackground()
    }
}

#Preview {
    ProfileView()
}

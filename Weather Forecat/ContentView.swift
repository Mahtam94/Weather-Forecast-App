//
//  ContentView.swift
//  Weather Forecat
//
//  Created by Mahta Moezzi on 04/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var City: String = ""
    @State private var Temperature: String = ""
    @State private var Desccription: String = ""
    var body: some View {
        VStack(spacing: 20) {
            Text("🌦️ Weather App")
                .font(.largeTitle)
                .bold()
            
            TextField("Enter city name", text: $City)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action:{
                fetchWeather(for: City)
            }) {
                Text("Get Weather")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            //show result
            if !Temperature.isEmpty && !Desccription.isEmpty {
                VStack(spacing: 10) {
                    Text("Temperature: \(Temperature)°C")
                        .font(.title2)
                    Text("Condition: \(Desccription)")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            Spacer()
        }
        .padding()
    }

    func fetchWeather(for city: String) {
        print("Fetching weather for \(City)...")
    }
}



#Preview {
    ContentView()
}

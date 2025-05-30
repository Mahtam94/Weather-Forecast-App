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
    @State private var Description: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        ZStack {
            // Background image that matches the weather
            Image(weatherBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
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
                Spacer()
                if isLoading {
                    ProgressView("Fetching weather...")
                        .padding()
                }
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                
                //.padding(.horizontal)
                
                //show result
                if !Temperature.isEmpty && !Description.isEmpty {
                    VStack(spacing: 10) {
                        Text("Temperature: \(Temperature)°C")
                            .font(.title2)
                        Text("Condition: \(Description)")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 30)
                    Spacer()
                    
                }
                    

            }
            .padding(.horizontal,60)
            .padding(.top, 50)
            
        }
    }
    
        

    func fetchWeather(for city: String) {
        isLoading = true // Start loading
        errorMessage = "" // reset previous error
        
        let apiKey = "APIKey123abc"
        let cityQuery = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityQuery)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL."
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false // Stop loading when done
            }
            if let error = error {
                errorMessage = "Failed to fetch data: \(error.localizedDescription)"
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                                errorMessage = "Could not find that city. Please try again."
                            }
                            return
                        }
            guard let data = data else {
                print("No data returned.")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    self.Temperature = String(format: "%.1f", decodedData.main.temp)
                    self.Description = decodedData.weather.first?.description.capitalized ?? "N/A"
                }
                
            } catch {
                print ("Error decodingg data: \(error.localizedDescription)")
            }
        }.resume()

    }
    var weatherBackground: String {
        let lowercased = Description.lowercased()

        if lowercased.contains("clear") {
            return "clear"
        } else if lowercased.contains("cloud") {
            return "cloudy"
        } else if lowercased.contains("rain") {
            return "rainy"
        } else if lowercased.contains("snow") {
            return "snowy"
        } else {
            return "default" // A safe fallback image
        }
    }
    
}



#Preview {
    ContentView()
}

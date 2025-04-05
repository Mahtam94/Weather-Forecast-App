//
//  weatherModel.swift
//  Weather Forecat
//
//  Created by Mahta Moezzi on 05/04/2025.
//

import Foundation

struct WeatherResponse: Codable {
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}

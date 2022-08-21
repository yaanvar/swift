//
//  APIResponse.swift
//  WeatherApp
//
//  Created by Anvar Rahimov on 21.08.2022.
//

import Foundation

struct ResponseBody: Codable {
    let coord: CoordResponse
    let weather: [WeatherResponse]
    let base: String
    let main: MainResponse
    let visibility: Int
    let wind: WindResponse
    let clouds: CloudsResponse
    let dt: Int
    let sys: SysResponse
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct CloudsResponse: Codable {
    let all: Int
}

// MARK: - Coord
struct CoordResponse: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct MainResponse: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct SysResponse: Codable {
    let type, id: Int
    let message: Double
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct WeatherResponse: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct WindResponse: Codable {
    let speed: Double
    let deg: Int
}

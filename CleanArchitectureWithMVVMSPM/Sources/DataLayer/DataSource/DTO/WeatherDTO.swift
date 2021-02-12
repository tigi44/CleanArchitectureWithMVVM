//
//  WeatherDTO.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import Foundation
import DomainLayer

public struct WeatherDTO: Codable {
    let weather: WeatherDataDTO
    let main: WeatherMainDTO
    let name: String
    let dt: TimeInterval
    
    // DTO: Data Transfer Object
    public func dto() -> WeatherEntity {
        return WeatherEntity(id: UUID().uuidString, icon: weather.icon, location: name, temperature: Float(main.temp), description: weather.description, date: Date(timeIntervalSince1970: dt))
    }
}

public struct WeatherDataDTO: Codable {
    let main: String
    let description: String
    let icon: String
}

public struct WeatherMainDTO: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

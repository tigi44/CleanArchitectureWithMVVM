//
//  WeatherEntity.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import Foundation

public struct WeatherEntity: Identifiable {
    public let id: String
    public let icon: String
    public let location: String
    public let temperature: Float
    public let description: String
    public let date: Date
    
    public init(id: String, icon: String, location: String, temperature: Float, description: String, date: Date)
    {
        self.id = id
        self.icon = icon
        self.location = location
        self.temperature = temperature
        self.description = description
        self.date = date
    }
}

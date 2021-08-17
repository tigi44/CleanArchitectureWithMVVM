//
//  WeatherDataSource.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import Foundation
import Combine
import DomainLayer

public protocol WeatherDataSourceInterface {
    func fetchDailyWeather() -> AnyPublisher<[WeatherDTO], Error>
}

public final class WeatherLocalDataSource: WeatherDataSourceInterface {
    
    public init() {}
    
    public func fetchDailyWeather() -> AnyPublisher<[WeatherDTO], Error> {
        return Just(dailyWeatherLocalData)
            .tryMap { try JSONSerialization.data(withJSONObject: $0, options: .prettyPrinted) }
            .decode(type: [WeatherDTO].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

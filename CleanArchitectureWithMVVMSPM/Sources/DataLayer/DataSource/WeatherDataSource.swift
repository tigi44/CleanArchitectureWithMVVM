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
    func fetchDailyWeather(completion: @escaping (Result<[WeatherDTO], Error>) -> Void) -> Cancellable?
}

public final class WeatherLocalDataSource: WeatherDataSourceInterface {
    
    public init() {}
    
    public func fetchDailyWeather(completion: @escaping (Result<[WeatherDTO], Error>) -> Void) -> Cancellable? {
        return Just(dailyWeatherLocalData)
            .tryMap { try JSONSerialization.data(withJSONObject: $0, options: .prettyPrinted) }
            .decode(type: [WeatherDTO].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .sink { dailyWeather in
                completion(.success(dailyWeather))
            }
    }
}

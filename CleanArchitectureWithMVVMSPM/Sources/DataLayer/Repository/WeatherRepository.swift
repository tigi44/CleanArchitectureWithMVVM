//
//  WeatherRepository.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import Foundation
import Combine
import DomainLayer

public final class WeatherRepository: WeatherRepositoryInterface {
    
    private let dataSource: WeatherDataSourceInterface
    
    public init(dataSource: WeatherDataSourceInterface) {
        self.dataSource = dataSource
    }
    
    public func fetchDailyWeather(completion: @escaping (Result<[WeatherEntity], Error>) -> Void) -> Cancellable? {
        
        return dataSource.fetchDailyWeather { result in
            switch result {
            case .success(let dailyWeather):
                var weatherEntities = [WeatherEntity]()
                for weather in dailyWeather {
                    weatherEntities.append(weather.dto())
                }
                completion(.success(weatherEntities))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

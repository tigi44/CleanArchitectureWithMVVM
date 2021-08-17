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
    
    public func fetchDailyWeather() -> AnyPublisher<[WeatherEntity], Error> {
        return dataSource.fetchDailyWeather()
            .map({ weatherDTOList in
                
                var weatherEntities = [WeatherEntity]()
                
                for weather in weatherDTOList {
                    weatherEntities.append(weather.dto())
                }
                
                return weatherEntities
            })
            .eraseToAnyPublisher()
    }
}

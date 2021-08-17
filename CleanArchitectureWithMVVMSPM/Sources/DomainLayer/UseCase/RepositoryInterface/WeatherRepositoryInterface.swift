//
//  WeatherRepositoryInterface.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import Foundation
import Combine

public protocol WeatherRepositoryInterface {
    func fetchDailyWeather() -> AnyPublisher<[WeatherEntity], Error>
}

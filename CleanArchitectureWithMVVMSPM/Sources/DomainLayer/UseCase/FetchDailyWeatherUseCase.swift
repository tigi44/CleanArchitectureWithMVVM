//
//  FetchDailyWeatherUseCase.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import Foundation
import Combine

public protocol FetchDailyWeatherUseCaseInterface {
    func execute(completion: @escaping (Result<[WeatherEntity], Error>) -> Void) -> Cancellable?
}

public final class FetchDailyWeatherUseCase: FetchDailyWeatherUseCaseInterface {

    private let repository: WeatherRepositoryInterface

    public init(repository: WeatherRepositoryInterface) {
        self.repository = repository
    }

    public func execute(completion: @escaping (Result<[WeatherEntity], Error>) -> Void) -> Cancellable? {
        return repository.fetchDailyWeather { result in
            completion(result)
        }
    }
}

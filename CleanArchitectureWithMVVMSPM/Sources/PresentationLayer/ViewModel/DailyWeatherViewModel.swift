//
//  DailyWeatherViewModel.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import Foundation
import Combine
import DomainLayer

public protocol DailyWeatherViewModelInput {
    func executeFetch()
}

public protocol DailyWeatherViewModelOutput {
    var dailyWeather: [WeatherEntity] { get }
}

public final class DailyWeatherViewModel: ObservableObject, DailyWeatherViewModelInput, DailyWeatherViewModelOutput {
    
    private let useCase: FetchDailyWeatherUseCaseInterface
    
    @Published public var dailyWeather: [WeatherEntity] = []
    
    public init(useCase: FetchDailyWeatherUseCaseInterface) {
        self.useCase = useCase
    }
    
    public func executeFetch() {
        var _ = useCase.execute { result in
            switch result {
            case .success(let dailyWeather):
                self.dailyWeather = dailyWeather
            case .failure:
                self.dailyWeather = []
            }
        }
    }
}

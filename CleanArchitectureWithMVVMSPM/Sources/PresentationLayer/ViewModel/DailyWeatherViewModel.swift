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
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published public var dailyWeather: [WeatherEntity] = []
    
    public init(useCase: FetchDailyWeatherUseCaseInterface) {
        self.useCase = useCase
    }
    
    public func executeFetch() {
        
        useCase.execute()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.dailyWeather = []
                }
            } receiveValue: { weatherList in
                self.dailyWeather = weatherList
            }
            .store(in: &bag)
    }
}

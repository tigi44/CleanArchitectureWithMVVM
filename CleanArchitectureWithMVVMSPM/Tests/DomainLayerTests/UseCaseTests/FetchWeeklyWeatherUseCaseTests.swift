//
//  FetchDailyWeatherUseCaseTests.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import XCTest
import Combine
@testable import DomainLayer

class MockWeatherRepository: WeatherRepositoryInterface {
    
    func fetchDailyWeather() -> AnyPublisher<[WeatherEntity], Error> {
        
        let dailyWeather = [
            WeatherEntity(id: "weather_mon", icon: "01d", location: "l", temperature: 10.1, description: "sunny", date: Date()),
            WeatherEntity(id: "weather_tue", icon: "01d", location: "l", temperature: 10.1, description: "sunny", date: Date()),
            WeatherEntity(id: "weather_wed", icon: "01d", location: "l", temperature: 10.1, description: "sunny", date: Date()),
            WeatherEntity(id: "weather_thu", icon: "01d", location: "l", temperature: 10.1, description: "sunny", date: Date()),
            WeatherEntity(id: "weather_fri", icon: "01d", location: "l", temperature: 10.1, description: "sunny", date: Date()),
            WeatherEntity(id: "weather_sat", icon: "01d", location: "l", temperature: 10.1, description: "sunny", date: Date()),
            WeatherEntity(id: "weather_sun", icon: "01d", location: "l", temperature: 10.1, description: "sunny", date: Date()),
        ]
        
        return Just(dailyWeather)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

final class FetchDailyWeatherUseCaseTests: XCTestCase {
    
    var useCase: FetchDailyWeatherUseCaseInterface?
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
        
        useCase = FetchDailyWeatherUseCase(repository: MockWeatherRepository())
        
        guard let _ = useCase else {
            XCTFail()
            return
        }
    }
    
    //MARK: - Tests
    
    func testExecute() {
        
        useCase!.execute()
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { weatherList in
                XCTAssertGreaterThan(weatherList.count, 0)
                for weather in weatherList {
                    XCTAssertNotNil(weather.id)
                }
            }
            .store(in: &bag)
    }

    static var allTests = [
        ("testExecute", testExecute),
    ]
}

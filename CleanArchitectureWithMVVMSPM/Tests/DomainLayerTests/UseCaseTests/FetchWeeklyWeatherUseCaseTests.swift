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
    func fetchDailyWeather(completion: @escaping (Result<[WeatherEntity], Error>) -> Void) -> Cancellable? {
        
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
            .sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { dailyWeather in
                completion(.success(dailyWeather))
            }
    }
}

final class FetchDailyWeatherUseCaseTests: XCTestCase {
    
    var useCase: FetchDailyWeatherUseCaseInterface?
    
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
        
        let _ = useCase!.execute { result in
            switch result {
            case .success(let dailyWeather):
                XCTAssertGreaterThan(dailyWeather.count, 0)
                for weather in dailyWeather {
                    XCTAssertNotNil(weather.id)
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }

    static var allTests = [
        ("testExecute", testExecute),
    ]
}

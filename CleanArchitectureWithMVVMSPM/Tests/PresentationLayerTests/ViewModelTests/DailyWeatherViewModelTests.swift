//
//  DailyWeatherViewModelTests.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import XCTest
import Combine
@testable import PresentationLayer
@testable import DomainLayer

class MockFetchDailyWeatherUseCase: FetchDailyWeatherUseCaseInterface {
    func execute(completion: @escaping (Result<[WeatherEntity], Error>) -> Void) -> Cancellable? {
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

final class DailyWeatherViewModelTests: XCTestCase {
    
    var viewModel: DailyWeatherViewModel?
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
        
        viewModel = DailyWeatherViewModel(useCase: MockFetchDailyWeatherUseCase())
        
        guard let _ = viewModel else {
            XCTFail()
            return
        }
    }
    
    //MARK: - Tests
    
    func testExecute() {
        
        let expectation = XCTestExpectation(description: self.description)
        
        let _ = viewModel!.$dailyWeather.sink { _ in
            
            expectation.fulfill()
        }
        
        viewModel!.executeFetch()
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertGreaterThan(viewModel!.dailyWeather.count, 0)
    }

    static var allTests = [
        ("testExecute", testExecute),
    ]
}

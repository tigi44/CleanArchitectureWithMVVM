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
    
    func execute() -> AnyPublisher<[WeatherEntity], Error> {
        
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

final class DailyWeatherViewModelTests: XCTestCase {
    
    var viewModel: DailyWeatherViewModel?
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
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
        
        viewModel!.$dailyWeather.sink { result in
            
            if result.count > 0 {
                XCTAssertGreaterThan(result.count, 0)
                expectation.fulfill()
            }
        }
        .store(in: &bag)
        
        viewModel!.executeFetch()
        
        wait(for: [expectation], timeout: 1)
    }

    static var allTests = [
        ("testExecute", testExecute),
    ]
}

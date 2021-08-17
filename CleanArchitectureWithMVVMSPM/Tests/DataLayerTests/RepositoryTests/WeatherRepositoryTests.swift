//
//  WeatherRepositoryTests.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import XCTest
import Combine
@testable import DataLayer
@testable import DomainLayer

final class WeatherRepositoryTests: XCTestCase {
    
    var reposotory: WeatherRepository?
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
        
        reposotory = WeatherRepository(dataSource: WeatherLocalDataSource())
        
        guard let _ = reposotory else {
            XCTFail()
            return
        }
    }
    
    //MARK: - Tests
    
    func testExecute() {
        
        reposotory!.fetchDailyWeather()
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
                    XCTAssertTrue(type(of: weather) == WeatherEntity.self)
                    XCTAssertNotNil(weather.icon)
                }
            }
            .store(in: &bag)
    }

    static var allTests = [
        ("testExecute", testExecute),
    ]
}

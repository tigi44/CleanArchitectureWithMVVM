//
//  WeatherRepositoryTests.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import XCTest
@testable import DataLayer
@testable import DomainLayer

final class WeatherRepositoryTests: XCTestCase {
    
    var reposotory: WeatherRepository?
    
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
        
        let _ = reposotory!.fetchDailyWeather { result in
            switch result {
            case .success(let dailyWeather):
                XCTAssertGreaterThan(dailyWeather.count, 0)
                for weather in dailyWeather {
                    XCTAssertTrue(type(of: weather) == WeatherEntity.self)
                    XCTAssertNotNil(weather.icon)
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

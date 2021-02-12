//
//  WeatherDataSourceTests.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import XCTest
@testable import DataLayer

final class WeatherDataSourceTests: XCTestCase {
    
    var dataSource: WeatherDataSourceInterface?
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
        
        dataSource = WeatherLocalDataSource()
        
        guard let _ = dataSource else {
            XCTFail()
            return
        }
    }
    
    //MARK: - Tests
    
    func testExecute() {
        
        let _ = dataSource!.fetchDailyWeather { result in
            switch result {
            case .success(let dailtWeather):
                XCTAssertGreaterThan(dailtWeather.count, 0)
                for weather in dailtWeather {
                    XCTAssertNotNil(weather.name)
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

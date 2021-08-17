//
//  WeatherDataSourceTests.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import XCTest
import Combine
@testable import DataLayer

final class WeatherDataSourceTests: XCTestCase {
    
    var dataSource: WeatherDataSourceInterface?
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
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
        
        dataSource!.fetchDailyWeather()
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { weatherDTOList in
                XCTAssertGreaterThan(weatherDTOList.count, 0)
                for weather in weatherDTOList {
                    XCTAssertNotNil(weather.name)
                }
            }
            .store(in: &bag)
    }

    static var allTests = [
        ("testExecute", testExecute),
    ]
}

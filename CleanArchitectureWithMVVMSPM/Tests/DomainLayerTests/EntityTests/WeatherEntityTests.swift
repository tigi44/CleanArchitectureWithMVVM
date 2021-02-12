//
//  WeatherEntityTests.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import XCTest
@testable import DomainLayer

final class WeatherEntityTests: XCTestCase {
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
    }
    
    //MARK: - Tests
    
    func testExecute() {
        
        let weatherEntity = WeatherEntity(id: "weather_1", icon: "sunny", location: "seongnam", temperature: 27.5, description: "sunny", date: Date())
        
        XCTAssertNotNil(weatherEntity)
        XCTAssertEqual(weatherEntity.id, "weather_1")
    }

    static var allTests = [
        ("testExecute", testExecute),
    ]
}

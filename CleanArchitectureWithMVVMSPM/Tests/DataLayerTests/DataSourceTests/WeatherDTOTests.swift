//
//  WeatherDTOTests.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import XCTest
import Combine
@testable import DataLayer

final class WeatherDTOTestsTests: XCTestCase {
    
    let weatherData = [
        "name": "seongnam",
        "dt": 1560350645,
        "weather": [
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01d"
        ],
        "main": [
            "temp": 282.55,
            "feels_like": 281.86,
            "temp_min": 280.37,
            "temp_max": 284.26,
            "pressure": 1023,
            "humidity": 100
        ]
    ] as [String : Any]
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
    }
    
    //MARK: - Tests
    
    func testExecute() {
        
        let _ = Just(weatherData)
            .tryMap { try JSONSerialization.data(withJSONObject: $0, options: []) }
            .decode(type: WeatherDTO.self, decoder: JSONDecoder())
            .sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { weatherDTO in
                XCTAssertNotNil(weatherDTO)
                XCTAssertGreaterThan(weatherDTO.weather.icon.count, 0)
            }
    }

    static var allTests = [
        ("testExecute", testExecute),
    ]
}

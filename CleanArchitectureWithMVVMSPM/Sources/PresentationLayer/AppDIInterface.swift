//
//  AppDIInterface.swift
//  
//
//  Created by tigi KIM on 2021/01/18.
//

import Foundation

public protocol AppDIInterface {
    func dailyWeatherDependencies() -> DailyWeatherViewModel
}

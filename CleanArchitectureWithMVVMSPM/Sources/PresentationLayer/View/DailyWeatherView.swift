//
//  DailyWeatherView.swift
//  
//
//  Created by tigi on 2021/02/12.
//

import SwiftUI

public struct DailyWeatherView: View {

    @ObservedObject public var viewModel: DailyWeatherViewModel
    
    public init(viewModel: DailyWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ScrollView() {
            Text("Daily Weather")
                .font(.title)
                .fontWeight(.bold)
            
            Spacer(minLength: 20)
            
            VStack(spacing: 40) {
                ForEach(self.viewModel.dailyWeather) { weather in
                    WeatherView(icon: weather.icon, location: weather.location, temperature: weather.temperature, date: weather.date)
                }
            }
        }
        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
        .onAppear {
            self.viewModel.executeFetch()
        }
    }

}

private struct WeatherView: View {
    
    let icon: String
    let location: String
    let temperature: Float
    let date: Date
    
    private var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd."
        return formatter
    }()
    
    init(icon: String, location: String, temperature: Float, date: Date) {
        self.icon = icon
        self.location = location
        self.temperature = temperature
        self.date = date
    }
    
    var body: some View {
        HStack(spacing: 20) {
            
            Image(icon, bundle: Bundle.module)
            
            VStack(alignment: .leading) {
                Text(formatter.string(from: date))
                    .font(.body)
                    .foregroundColor(.gray)
                Text(location)
                    .font(.title)
                
                Spacer()
                
                Text(String(format: " %.1f °C", temperature))
                    .font(.title)
                    .fontWeight(.bold)
            }
        }
        .padding(10)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(25)
    }
}

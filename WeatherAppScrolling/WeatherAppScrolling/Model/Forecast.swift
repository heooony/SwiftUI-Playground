//
//  Forecast.swift
//  WeatherAppScrolling
//
//  Created by 김동헌 on 2022/07/02.
//

import SwiftUI

// sample model and ten days data

struct DayForecast: Identifiable, Equatable {
    var id = UUID().uuidString
    var day: String
    var farenheit: CGFloat
    var image: String
}

var forecast = [
    DayForecast(day:"Today", farenheit: 22, image: "sun.min"),
    DayForecast(day:"Wed", farenheit: 20, image: "cloud.sun"),
    DayForecast(day:"Tue", farenheit: 24, image: "cloud.sun.bolt"),
    DayForecast(day:"Thu", farenheit: 25, image: "sun.max"),
    DayForecast(day:"Fri", farenheit: 23, image: "cloud.sun"),
    DayForecast(day:"Sat", farenheit: 20, image: "cloud.sun"),
    DayForecast(day:"Sun", farenheit: 25, image: "sun.max"),
    DayForecast(day:"Mon", farenheit: 26, image: "sun.max"),
    DayForecast(day:"Tue", farenheit: 27, image: "cloud.sun.bolt"),
    DayForecast(day:"Wed", farenheit: 25, image: "sun.min")
]

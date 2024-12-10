//
//  WeatherData.swift
//  Clima
//
//  Created by Yuunan kin on 2024/12/09.
//
struct WeatherData: Decodable {
    let name: String
    let main: WeatherDataMain
    let weather: [WeatherDataWeather]
}

struct WeatherDataMain: Decodable {
    let temp: Double
}

struct WeatherDataWeather: Decodable {
    let id: Int
}

//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Yuunan kin on 2024/12/10.
//

protocol WeatherManagerDelegate {
    func onWeatherFetched(_ weather: Weather)
    func onFailed(_ error: Error)
}

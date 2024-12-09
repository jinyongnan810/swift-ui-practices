//
//  WeatherManager.swift
//  Clima
//
//  Created by Yuunan kin on 2024/12/09.
//
import Foundation

struct WeatherManager {
    var url = "https://api.openweathermap.org/data/2.5/weather?appid=e0e154d6de04f7eb12b44c810c9fb69a&units=metric"

    func fetch(_ name: String) {
        let urlWithCity = "\(url)&q=\(name)"
        guard let url = URL(string: urlWithCity) else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {
            data,
                _,
                error in
            if error != nil {
                print("Error: \(error!.localizedDescription)")
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decoded = try JSONDecoder().decode(
                    WeatherData.self,
                    from: data
                )
                print(
                    "name: \(decoded.name), temp: \(decoded.main.temp), weather: \(decoded.weather.first?.description)"
                )
            } catch {
                print("Error decoding: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

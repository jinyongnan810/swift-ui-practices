//
//  WeatherManager.swift
//  Clima
//
//  Created by Yuunan kin on 2024/12/09.
//
import Foundation

struct WeatherManager {
    var delegate: WeatherManagerDelegate?

    var url = "https://api.openweathermap.org/data/2.5/weather?appid=e0e154d6de04f7eb12b44c810c9fb69a&units=metric"

    func request(withName cityName: String) {
        let urlWithCity = "\(url)&q=\(cityName)"
        requestWeather(urlWithCity)
    }

    func request(withlat lat: Double, andLon lon: Double) {
        let urlWithLatLon = "\(url)&lat=\(lat)&lon=\(lon)"
        print("⭐️url:\(urlWithLatLon)")
        requestWeather(urlWithLatLon)
    }

    private func requestWeather(_ url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {
            data,
                _,
                error in
            if error != nil {
                delegate?.onFailed(error!)
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
                let weather = Weather(
                    weatherId: decoded.weather.first?.id ?? 0,
                    city: decoded.name,
                    temperature: decoded.main.temp
                )
                delegate?.onWeatherFetched(weather)
            } catch {
                delegate?.onFailed(error)
            }
        }
        task.resume()
    }
}

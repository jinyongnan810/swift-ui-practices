//
//  Weather.swift
//  Clima
//
//  Created by Yuunan kin on 2024/12/10.
//

struct Weather {
    let weatherId: Int
    let city: String
    let temperature: Double

    var temperatureString: String {
        String(format: "%.1f", temperature)
    }

    var icon: String {
        switch weatherId {
        case 200 ... 232:
            return "cloud.bolt"
        case 300 ... 321:
            return "cloud.drizzle"
        case 500 ... 531:
            return "cloud.rain"
        case 600 ... 622:
            return "cloud.snow"
        case 701 ... 781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801 ... 802:
            return "sun.min"
        case 801 ... 804:
            return "cloud"
        default:
            return "cloud"
        }
    }
}

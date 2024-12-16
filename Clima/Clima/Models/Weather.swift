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
            "cloud.bolt"
        case 300 ... 321:
            "cloud.drizzle"
        case 500 ... 531:
            "cloud.rain"
        case 600 ... 622:
            "cloud.snow"
        case 701 ... 781:
            "cloud.fog"
        case 800:
            "sun.max"
        case 801 ... 802:
            "sun.min"
        case 801 ... 804:
            "cloud"
        default:
            "cloud"
        }
    }
}

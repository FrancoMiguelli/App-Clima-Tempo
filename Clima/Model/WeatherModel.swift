//
//  WeatherModel.swift
//  Clima
//
//  Created by Midas Tecnologia on 01/03/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let id: Int
    let temp: Double
    let cityName: String
    
    var temperatureString: String {
        return String(format: "%.1f", temp)
    }
    
    var getConditionsName: String {
        switch id {
        case 200 ... 232:
            return "cloud.bolt"
        case 300 ... 321:
            return "cloud.heavyrain"
        case 500 ... 504:
            return "cloud.sun.rain"
        case 511:
            return "cloud.snow"
        case 520 ... 531:
            return "cloud.heavyrain"
        case 600 ... 622:
            return "snow"
        case 701 ... 781:
            return "smoke"
        case 800:
            return "sun.max"
        case 801:
            return "cloud.sun"
        default:
            return "cloud.fill"
        }
    }
}

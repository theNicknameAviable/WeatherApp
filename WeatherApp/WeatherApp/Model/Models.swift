//
//  Models.swift
//  WeatherApp
//
//  Created by Raul Bautista on 6/4/22.
//

import Foundation

struct WeatherResponse: Decodable {
    let weather: String
    let cityName: String
}

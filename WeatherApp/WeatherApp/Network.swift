//
//  Network.swift
//  WeatherApp
//
//  Created by Raul Bautista on 15/4/22.
//

import Foundation
import Alamofire

class Network {
    
    static let apiKey = "ca4a0a40199b5d50b1a9fa8a2bc669b1"
    
    func requests(completionBlock: @escaping ([WeatherResponse]) -> Void ) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=\(Network.apiKey)"
        AF.request(url).responseDecodable(of:sunInMadrid.self) { response in
            let weather = try? response.result.get().results
            completionBlock(weather ?? [])
        }
    }
}

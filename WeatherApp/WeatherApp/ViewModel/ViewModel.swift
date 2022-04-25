//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Raul Bautista on 6/4/22.
//

import Foundation

class WeatherConsult {
    
    var weatherToday: [WeatherResponse] = []
    let networkWorker: Network
    
    init(networkWoker: Network = Network()){
        self.networkWorker = networkWoker
    }
    
    var completionLabel: ((String) -> Void)?
    
    func userDidTapButton() {
        networkWorker.requests { weatherToday in
            self.weatherToday = weatherToday
            self.completionLabel?("")
        }
    }
}

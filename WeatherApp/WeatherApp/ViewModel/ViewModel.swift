//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Raul Bautista on 6/4/22.
//

import Foundation

class WeatherConsult {
    
    let networkWorker: Network
    init(networkWoker: Network = Network()){
        self.networkWorker = networkWoker
    }
    
    var completionLabel: ((String) -> Void)?
    
    func userDidTapButton() {
        let weatherResult: String = "32º"
        completionLabel?("\(weatherResult)")
    }
}

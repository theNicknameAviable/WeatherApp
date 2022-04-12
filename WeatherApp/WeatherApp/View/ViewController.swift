//
//  ViewController.swift
//  WeatherApp
//
//  Created by Raul Bautista on 6/4/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var infoWeather: UILabel!
    @IBOutlet weak var buttonConsult: UIButton!
    let weatherConsultModel = WeatherConsult()
    
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

// MARK: - Configure View
extension ViewController {
    
    func configureView() {
        infoWeather.textColor = .black
        infoWeather.backgroundColor = .yellow
        buttonConsult.setTitle("Consult", for: .normal)
        buttonConsult.setTitleColor(.black, for: .normal)
        buttonConsult.backgroundColor = .yellow
        
    }
}


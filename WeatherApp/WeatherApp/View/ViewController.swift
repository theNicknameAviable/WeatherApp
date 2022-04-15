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
    
    /*required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

// MARK: - Configure View
extension ViewController {
    
    func configureView() {
        infoWeather.textColor = .black
        infoWeather.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.28, alpha: 1.00)
        infoWeather.layer.cornerRadius = 10
        infoWeather.layer.masksToBounds = true
        buttonConsult.setTitle("Consult", for: .normal)
        buttonConsult.setTitleColor(.black, for: .normal)
        buttonConsult.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.28, alpha: 1.00)
        buttonConsult.layer.cornerRadius = 10
        weatherConsultModel.completionLabel = { temp in
            self.infoWeather.text = temp
        }
        
    }
}

// MARK: - Configure Button

extension ViewController {
    
    @IBAction func buttonAction() {
        weatherConsultModel.userDidTapButton()
    }
}


//
//  Constants.swift
//  Clima
//
//  Created by 황원상 on 2022/07/04.
//

import Foundation

struct Constants{
    
    struct Network{
        static let personalID = "982ed99c4f0658981ade1c3e274c95bf"
        static let url = "https://api.openweathermap.org/data/2.5/weather?appid=\(personalID)&q="
        
    }
    
    private init(){}
}


protocol NetworkDelegate{
    func reloadView(_ value: WeatherModel)
}

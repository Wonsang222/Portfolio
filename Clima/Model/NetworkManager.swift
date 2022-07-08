//
//  NetworkManager.swift
//  Clima
//
//  Created by 황원상 on 2022/07/04.
//

import Foundation
import CoreLocation

enum NetworkError:Error{
    case networkError
    case dataError
    case parseError
}


class NetworkManager{
    
    var delegate:NetworkDelegate?
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "https://api.openweathermap.org/data/2.5/weather?appid=e72ca729af228beabd5d20e3b7749713&units=metric&lat=\(latitude)&lon=\(longitude)"
        performRequest(value: urlString)
    }
    
    func fetchWeather(city:String){
        
        let urlString = Constants.Network.url+city
        performRequest(value: urlString)
    }
    
    func performRequest(value:String){
        guard let url = URL(string: value) else { return  }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil{
                print(error!)
                return
            }
            
            guard let safeData = data else { return }
            
            guard let safeWeather = self.parseJson(safedata: safeData) else { return }
            
            DispatchQueue.main.async {
             self.delegate?.reloadView(safeWeather)
            }
        }
        task.resume()
    }
    func parseJson(safedata:Data)->WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let weather = try decoder.decode(Weather1.self, from: safedata)
            let weatherModel = WeatherModel(cityname: weather.name, temp: weather.main.temp, id: weather.weather[0].id)
            return weatherModel
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
    
    static let shared = NetworkManager()
    private init(){}
}

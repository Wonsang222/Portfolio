//
//  ViewController.swift
//  Clima
//
//  Created by 황원상 on 2022/07/04.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
    
    var myView = myUIView()
    
    let locationManager = CLLocationManager() //
    
    var weatherModel:WeatherModel?
      
    let network = NetworkManager.shared
    
    override func loadView() {
        view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTextfield()
        network.delegate = self
//        let a = #imageLiteral(resourceName: "AppBackground")
//        view.backgroundColor = UIColor(patternImage: a)
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
           backgroundImage.image = UIImage(named: "AppBackground")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
           self.view.insertSubview(backgroundImage, at: 0)
        myView.finderButton.addTarget(self, action: #selector(finderbuttonTapped), for: .touchUpInside)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        myView.locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
    }
    
    @objc func locationButtonTapped(){
        locationManager.requestLocation()
    }
    
    func setupTextfield(){
        myView.tf.delegate = self
    }
}

//MARK: - TextField Delegate
extension ViewController:UITextFieldDelegate{
    @objc func finderbuttonTapped(){
        myView.tf.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myView.tf.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        myView.tf.text = ""
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            network.fetchWeather(city: textField.text ?? "")
            return true
        }else{
        textField.placeholder = "Type Something Plz"
        return false
    }
    }
}

//MARK: - Delegate Pattern
extension ViewController:NetworkDelegate{
    func reloadView(_ value: WeatherModel) {
        myView.cityLable.text = value.cityname
        myView.tempLable.text = value.temperatureString
        myView.image.image = UIImage(systemName: value.conditionName)
    }
}

//MARK: - Location
extension ViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            print(lat)
            let lon = location.coordinate.longitude
            print(lon)
            network.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


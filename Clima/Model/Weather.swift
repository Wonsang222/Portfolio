//
//  Weather.swift
//  Clima
//
//  Created by 황원상 on 2022/07/04.
//

import Foundation



// MARK: - Welcome
struct Weather1: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}


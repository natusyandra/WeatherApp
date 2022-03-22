//
//  KelvinToCelciusConverter.swift
//  WeatherApp
//
//  Created by Котик on 11.03.2022.
//

import Foundation
import UIKit

extension Float {
    func truncate(places : Int)-> Float {
        return Float(floor(pow(10.0, Float(places)) * self)/pow(10.0, Float(places)))
    }
    
    func kelvinToCeliusConverter() -> Float {
        let constantVal : Float = 273.15
        let kelValue = self
        let celValue = kelValue - constantVal
        return celValue.truncate(places: 1)
    }
    
    func celcius() -> String {
        return String(format: "%.0f", self.kelvinToCeliusConverter()) + " °C"
    }
}

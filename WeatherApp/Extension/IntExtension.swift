//
//  IntExtension.swift
//  WeatherApp
//
//  Created by Котик on 11.03.2022.
//

import Foundation
import UIKit

extension Int {
    func incrementWeekDays(by num: Int) -> Int {
        let incrementedVal = self + num
        let mod = incrementedVal % 7
        
        return mod
    }
}

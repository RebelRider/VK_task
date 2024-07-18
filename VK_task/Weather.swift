//
//  Weather.swift
//  VK_task
//
//  Created by Kirill Smirnov on 18.07.2024.
//

import Foundation

struct Weather {
    let name: String
    let imageName: String
    let sfSymbolName: String

    static let allWeathers: [Weather] = [
        Weather(name: NSLocalizedString("Clear", comment: ""), imageName: "clear", sfSymbolName: "sun.max.fill"),
        Weather(name: NSLocalizedString("Rain", comment: ""), imageName: "rain", sfSymbolName: "cloud.rain.fill"),
        Weather(name: NSLocalizedString("Storm", comment: ""), imageName: "storm", sfSymbolName: "cloud.bolt.fill"),
        Weather(name: NSLocalizedString("Fog", comment: ""), imageName: "fog", sfSymbolName: "cloud.fog.fill"),
        Weather(name: NSLocalizedString("Snow", comment: ""), imageName: "snow", sfSymbolName: "snow"),
        Weather(name: NSLocalizedString("Cloudy", comment: ""), imageName: "cloudy", sfSymbolName: "cloud.fill")
    ]
}

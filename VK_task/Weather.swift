//
//  Weather.swift
//  VK_task
//
//  Created by Kirill Smirnov on 18.07.2024.
//

import UIKit

struct Weather {
    let name: String
    let animation: String
    let imageName: String

    static let allWeathers: [Weather] = [
        Weather(name: NSLocalizedString("Clear", comment: ""), animation: "clearAnimation", imageName: "clear"),
        Weather(name: NSLocalizedString("Rain", comment: ""), animation: "rainAnimation", imageName: "rain"),
        Weather(name: NSLocalizedString("Storm", comment: ""), animation: "stormAnimation", imageName: "storm"),
        Weather(name: NSLocalizedString("Fog", comment: ""), animation: "fogAnimation", imageName: "fog")
    ]
}


//
//  NotificationKeys.swift
//  WeatherAPP
//
//  Created by hyeri kim on 04/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

struct NotificationKey {
    static let selectCityNotification = "select.city"
    static let selectFahrenheitOrCelsiusNotification = "select.fahrenheitOrCelsius"
}

extension Notification.Name {
    static let selectCity = Notification.Name(NotificationKey.selectCityNotification)
    static let selectFahrenheitOrCelsius = Notification.Name(NotificationKey.selectFahrenheitOrCelsiusNotification)
}

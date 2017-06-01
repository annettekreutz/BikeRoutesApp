//
//  BikeRoute.swift
//  BikeHistorie
//
//  Created by Team_iOS on 30.05.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//

import Foundation

struct BikeRoute {

    let driveDuration: TimeInterval
    let distance: Double
    let tourBreakCount: Int
    let date: Date
    let temperatur: Double
    
    var startCriteria = ReviewBikeCriteria()
    var finishCriteria = ReviewBikeCriteria()

}

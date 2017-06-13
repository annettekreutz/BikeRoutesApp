//
//  BikeRoute.swift
//  BikeHistorie
//
//  Created by Team_iOS on 30.05.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//

import Foundation

struct BikeRoute {
 
    // transfer data from edit view to table view
    let driveDuration: TimeInterval
    let location: String
    let distance: Double
    let tourBreakCount: Int
    let date: Date
    let temperatur: Double
    
    var startCriteria = ReviewBikeCriteria()
    var finishCriteria = ReviewBikeCriteria()

    
}

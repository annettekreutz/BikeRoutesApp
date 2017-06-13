//
//  MapLocation.swift
//  BikeHistorie
//
//  Created by Team_iOS on 08.06.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//
import Foundation


class MapLocation{
    // transfer data from map view to edit view
    var location = String()
    var latitude = Double()
    var longitude = Double()
    var temp = String()
    
    init(mapLocation : MapLocation) {
        self.location = mapLocation.location
        self.latitude = mapLocation.latitude
        self.longitude = mapLocation.longitude
        self.temp = mapLocation.temp
    }
    
    init(location: String ,latitude : Double,  longitude : Double, temp: String = "") {
        self.location = location
        self.temp = temp
        self.latitude = latitude
        self.longitude = longitude
    }

    convenience init() {
        self.init(location: String(), latitude: Double(), longitude: Double(), temp: String())
    }
}

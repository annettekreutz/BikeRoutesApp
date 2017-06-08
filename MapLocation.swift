//
//  MapLocation.swift
//  BikeHistorie
//
//  Created by Team_iOS on 08.06.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//

import Foundation



class MapLocation{
    
    var location = String()
    var latitude = Double()
    var longitude = Double()
    
   // var mapEnumCriteria : [EnumCriteria: EnumStar] = [:] {
//        willSet(newMapEnumCriteria) {
//            print("About to set totalSteps to \(newMapEnumCriteria)")
//        }
//        didSet {
//            print("Added \(oldValue) steps")
//        }
//    }
    init(mapLocation :MapLocation) {
        self.location = mapLocation.location
        self.latitude = mapLocation.latitude
        self.longitude = mapLocation.longitude
    }
    
    init(location: String,latitude : Double,  longitude : Double) {
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
    }
//    
//    init(mapEnumCriteria: [EnumCriteria: EnumStar]) {
//        self.mapEnumCriteria = mapEnumCriteria
//    }
    
    convenience init() {
        self.init(location: String(), latitude: Double(), longitude: Double())
        //self.init(mapEnumCriteria: [:])
        //mapEnumCriteria[EnumCriteria.breaking]=EnumStar.star1
    }
}

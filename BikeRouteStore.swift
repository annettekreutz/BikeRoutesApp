//
//  BikeStore.swift
//  BikeHistorie
//
//  Created by Team_iOS on 30.05.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//

import Foundation

extension ReviewBikeCriteria {
    func toDictionary() -> [String: Int] {
        var result = [String: Int]()
        for dic in self.mapEnumCriteria {
            result[dic.key.rawValue]  =  dic.value.rawValue
        }
        return result
    }
    
    convenience init(dicionary: [String: Int]) {
        var result = [EnumCriteria: EnumStar]()
        for dic in dicionary {
            result[EnumCriteria(rawValue: dic.key)!]=EnumStar(rawValue: dic.value)!
        }
        
        self.init()
        self.mapEnumCriteria = result
    }
}

extension BikeRoute {
    
    func toDictionary() -> [String: Any] {
        return ["driveDuration": driveDuration, "distance": distance, "tourBreakCount": tourBreakCount, "date": date, "temperatur": temperatur,
            "startCriteria": startCriteria.toDictionary(),
            "finishCriteria": finishCriteria.toDictionary()
        ]
    }
    
    init(dicionary: [String: Any]) {
        self.driveDuration = dicionary["driveDuration"] as! TimeInterval
        self.distance = dicionary["distance"] as! Double
        self.tourBreakCount = dicionary["tourBreakCount"] as! Int
        self.date = dicionary["date"] as! Date
        self.temperatur = dicionary["temperatur"] as! Double
        self.finishCriteria = ReviewBikeCriteria(dicionary: dicionary["finishCriteria"] as! [String: Int])
        self.startCriteria = ReviewBikeCriteria(dicionary: dicionary["startCriteria"] as! [String: Int])
    }
}

protocol BikeRouteStoreing {
    func store(bikeRoute: BikeRoute)
    
    func getAllBikeRoutes() -> [BikeRoute]
}

class BikeRouteStore: BikeRouteStoreing {
    private let userDefaultsKey = "BikeRouteStore"
    private let userDefaults = UserDefaults.standard
    
    func store(bikeRoute: BikeRoute) {
        var array = getSerializedData()
        //Add new Data
        array.append(bikeRoute.toDictionary())
        
        //Write to disk
        userDefaults.set(array, forKey: userDefaultsKey)
        userDefaults.synchronize()
    }
    
    private func getSerializedData() -> [Dictionary<String, Any>] {
        //Get list from Disk
        let untypedStoredData = userDefaults.array(forKey: userDefaultsKey)
        let storedData = untypedStoredData as? [Dictionary<String, Any>]  // == [[String: Int]]
        return storedData ?? []
    }
    
    func getAllBikeRoutes() -> [BikeRoute] {
        var result = [BikeRoute]()
        for bikeRouteKeyValue in getSerializedData() {
            result.append(BikeRoute(dicionary: bikeRouteKeyValue))
        }
        
        return result
    }
}



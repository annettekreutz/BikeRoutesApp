//
//  ReviewBikeCriterias.swift
//  BikeHistorie
//
//  Created by Team_iOS on 01.06.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//

//
//  ReviewBikeCriteria.swift
//  BikeHistorie
//
//  Created by Team_iOS on 30.05.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//
import Foundation


class ReviewBikeCriteria {
    // transfer data from review view to edit view
    var mapEnumCriteria : [EnumCriteria: EnumStar] = [:] {
        willSet(newMapEnumCriteria) {
            print("About to set totalSteps to \(newMapEnumCriteria)")
        }
        didSet {
            print("Added \(oldValue) steps")
        }
    }
    
    init(mapEnumCriteria: [EnumCriteria: EnumStar]) {
        self.mapEnumCriteria = mapEnumCriteria
    }
    
    convenience init() {
        self.init(mapEnumCriteria: [:])
    }
}

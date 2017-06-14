//
//  CalcCriteria.swift
//  BikeHistorie
//
//  Created by Team_iOS on 01.06.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//

import Foundation

class CalcCriteria  {
    // calc average of criteria of map list 
//    static func calcAverage (reviewBikeCriteria :ReviewBikeCriteria)-> Int{
//        var allNumbers = Int()
//        let count = reviewBikeCriteria.mapEnumCriteria.count
//        if count <= 0 {return 0}
//        for bike in reviewBikeCriteria.mapEnumCriteria{
//            let enumCriteria = bike.key
//            let destinationCrit  = reviewBikeCriteria.mapEnumCriteria[enumCriteria]
//            let number : Int = destinationCrit!.rawValue
//            allNumbers += number
//          //  print (allNumbers, number)
//        }
//        let result = allNumbers/count
//        return result
//    }
    static func calcAverage (cdReviewBikeCriteria :CDReviewBikeCriteria)-> Int{
        var allNumbers = cdReviewBikeCriteria.breaking
        allNumbers += cdReviewBikeCriteria.kurve
        allNumbers += cdReviewBikeCriteria.quickly
        allNumbers += cdReviewBikeCriteria.slowly
        allNumbers += cdReviewBikeCriteria.starting
        allNumbers += cdReviewBikeCriteria.turn
        let r =  allNumbers / 6
        let result = Int(r)
        print(result)
        return result as Int
        
    }
    
}

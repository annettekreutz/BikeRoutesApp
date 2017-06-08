import Foundation

class CalcCriteria  {
    static func calcAverage (reviewBikeCriteria :ReviewBikeCriteria)-> Int{
        var allNumbers = Int()
        let count = reviewBikeCriteria.mapEnumCriteria.count
        for bike in reviewBikeCriteria.mapEnumCriteria{
            let enumCriteria = bike.key
            let destinationCrit  = reviewBikeCriteria.mapEnumCriteria[enumCriteria]
            let number : Int = destinationCrit!.rawValue
            allNumbers += number
            print (allNumbers, number)
        }
        let result = allNumbers/count
        return result
    }
}

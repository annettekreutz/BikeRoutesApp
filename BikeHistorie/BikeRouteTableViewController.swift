//
//  BikeRouteTableViewController.swift
//  BikeHistorie
//
//  Created by Team_iOS on 30.05.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//

import UIKit

class BikeRouteTableViewController : UITableViewController {
    
    let bikeRouteStore = BikeRouteStore()

    // Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return bikeRouteStore.getAllBikeRoutes().count
        default:
            return 1
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BikeRouteCell", for: indexPath) as! BikeRouteTableViewCell
            
            let bikeRoute = bikeRouteStore.getAllBikeRoutes()[indexPath.row]
            cell.dateLabel.text =   DateFormatter.standard.string(from: bikeRoute.date)
            cell.durationLabel.text = "Kilometerstand: \(bikeRoute.driveDuration)"
            cell.distanceLabel.text =  "gefahren: \(bikeRoute.distance)"
            cell.tourBreakCountLabel.text =  "Pausen: \(bikeRoute.tourBreakCount)"
            cell.temperaturLabel.text =  "Temperatur: \(bikeRoute.temperatur)"
            //if var count = bikeRoute.finishCriteria.mapEnumCriteria.count{
            let mapEnumCriteria = bikeRoute.finishCriteria.mapEnumCriteria
            var cnt : Int? = mapEnumCriteria.count
            if cnt != nil {
                for bike in mapEnumCriteria {
                    let enumCriteria = bike.key
                    let destinationCrit  = mapEnumCriteria[enumCriteria]
                    var destinationFl = Int()
                    if let tmp = destinationCrit?.rawValue {
                        destinationFl = Int(tmp)
                        print( destinationFl)
                    }
                }
             }
            
            cell.temperaturLabel.text =  "Temperatur: \(bikeRoute.toDictionary().count)"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BikeRouteCell2", for: indexPath)
            
            cell.textLabel?.text = "Hier könnte Deine Werbung stehen!"
            
            return cell
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }

}

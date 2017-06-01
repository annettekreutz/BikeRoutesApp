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
           
            
           cell.dateLabel.text = DateFormatter.standard.string(from: bikeRoute.date)
             
            
            cell.durationLabel.text = String(bikeRoute.driveDuration)
            cell.distanceLabel.text =  String(bikeRoute.distance)
            
            cell.tourBreakCountLabel.text =  String(bikeRoute.tourBreakCount)
            cell.temperaturLabel.text =  String(bikeRoute.temperatur)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BikeRouteCell2", for: indexPath)
            
            cell.textLabel?.text = "Kauf mich bitte!"
            
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

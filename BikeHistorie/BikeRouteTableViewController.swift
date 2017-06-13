//
//  BikeRouteTableViewController.swift
//  BikeHistorie
//
//  Created by Team_iOS on 30.05.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//

import UIKit

class BikeRouteTableViewController : UITableViewController{
    
    let bikeRouteStore = BikeRouteStore()
    
    // view starting
    override func viewDidLoad() {
        navigationItem.title = "Bike Routes"
    }

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
    // write all cells by bike record
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BikeRouteCell", for: indexPath) as! BikeRouteTableViewCell
            let bikeRoute = bikeRouteStore.getAllBikeRoutes()[indexPath.row]
            cell.dateLabel.text =  "\( DateFormatter.standard.string(from: bikeRoute.date))"
            cell.distanceLabel.text =  "\(bikeRoute.distance) km nach: \(bikeRoute.location)"
            cell.beforeReview.text =  "\(CalcCriteria.calcAverage(reviewBikeCriteria:bikeRoute.startCriteria))"
            cell.finishReview.text = " \(CalcCriteria.calcAverage(reviewBikeCriteria: bikeRoute.finishCriteria))"
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BikeRouteCell2", for: indexPath)
            
            
            cell.textLabel?.text = infoOfSystemRecord()
            return cell
        }
    }
    func infoOfSystemRecord()-> String{
        let bikeRoutes = bikeRouteStore.getAllBikeRoutes()
        let countDrive = bikeRoutes.count
        if(countDrive<=0){
            return "keine Fahrten enthalten"
            
        }
        var countKm = 0.0
        for bikeRoute in bikeRoutes {
            let km =  bikeRoute.distance
            countKm = countKm + km
        }
        return "\(countDrive) Fahrten (\(countKm) km)"
    }
    
    // do delete copy selected record
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // action one
        let insertAction = UITableViewRowAction(style: .default, title: "Copy", handler: { (action, indexPath) in
             print("Copy tapped")
            
            let bikeRoute = self.bikeRouteStore.getAllBikeRoutes()[indexPath.row]
            self.bikeRouteStore.insert(bikeRoute: bikeRoute)
            tableView.reloadData()
         })
         insertAction.backgroundColor = UIColor.blue
    
         // action two
         let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
            
            let index = Int(indexPath.row)
            // remove the item from the data model
            self.bikeRouteStore.remove(indexOfList: index)
            
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
                    })
        deleteAction.backgroundColor = UIColor.red
        
        return [insertAction, deleteAction]
    }
    @IBAction func editEntry(_ sender: Any) {
        print ("editEntry() ")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    // cache edited record for saving
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editBikeTour" {
            guard let editBikeTourNavigationController = segue.destination as? UINavigationController, let editBikeTourViewController = editBikeTourNavigationController.viewControllers.first as? NewBikeTourViewController else {
                return
            }
            let indexPath = tableView.indexPathForSelectedRow?.row
            let bikerRoute = bikeRouteStore.getAllBikeRoutes()[indexPath!]
            editBikeTourViewController.setAttributes(bikeRoute: bikerRoute, tableIndex: indexPath!)
        }
    }
}

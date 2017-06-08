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
    func calcReview (reviewBikeCriteria : ReviewBikeCriteria) -> Int{
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
        return  result
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BikeRouteCell", for: indexPath) as! BikeRouteTableViewCell
            let bikeRoute = bikeRouteStore.getAllBikeRoutes()[indexPath.row]
            cell.dateLabel.text =  "gefahren am \( DateFormatter.standard.string(from: bikeRoute.date))"
            cell.distanceLabel.text =  "\(bikeRoute.distance) km"
            cell.ortLabel.text = "nach: \(bikeRoute.location)"
            cell.finishReview.text = "Bewertung: \(calcReview(reviewBikeCriteria: bikeRoute.finishCriteria)) - \(calcReview(reviewBikeCriteria: bikeRoute.startCriteria))"
           // cell.durationLabel.text = "Kilometerstand: \(bikeRoute.driveDuration)"
                     //  cell.tourBreakCountLabel.text =  "Pausen: \(bikeRoute.tourBreakCount)"
         //   cell.temperaturLabel.text =  "Temperatur: \(bikeRoute.temperatur) Grad"
          //  cell.beforeReview.text =  "Hin: \(calcReview(reviewBikeCriteria: bikeRoute.startCriteria))"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BikeRouteCell2", for: indexPath)
            cell.textLabel?.text = "Hier könnte Deine Werbung stehen!"
            return cell
        }
    }
 // see https://stackoverflow.com/questions/3309484/uitableviewcell-show-delete-button-on-swipe
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        //let bikeRoute = bikeRouteStore.getAllBikeRoutes()[indexPath.row]
//        let bikeRoute = bikeRouteStore.getAllBikeRoutes()[indexPath.row]
//
//        
//        if editingStyle == .delete {
//            
//            let index = Int(indexPath.row)
//            // remove the item from the data model
//            bikeRouteStore.remove(indexOfList: index)
//
//            // delete the table view row
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            
//        } else if editingStyle == .insert {
//            // Not used in our example, but if you were adding a new row, this is where you would do it.
//           bikeRouteStore.insert(bikeRoute: bikeRoute)
//        }
//    }
    
     override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // action one
        let insertAction = UITableViewRowAction(style: .default, title: "Copy", handler: { (action, indexPath) in
             print("Copy tapped")
            
            let bikeRoute = self.bikeRouteStore.getAllBikeRoutes()[indexPath.row]
            self.bikeRouteStore.insert(bikeRoute: bikeRoute)
            tableView.reloadData()
         })
         insertAction.backgroundColor = UIColor.blue
        
        // action one
//        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
//            print("Edit tapped")
//            
//            let bikeRoute = self.bikeRouteStore.getAllBikeRoutes()[indexPath.row]
//         //   driveReviewViewController DriveReviewViewController
//            // TODO save state of edit
//            // load 
//            
//           // self.bikeRouteStore.insert(bikeRoute: bikeRoute)
//            tableView.reloadData()
//        })
//        editAction.backgroundColor = UIColor.yellow

        
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
    override var prefersStatusBarHidden: Bool{
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editBikeTour" {
            guard let editBikeTourNavigationController = segue.destination as? UINavigationController, let editBikeTourViewController = editBikeTourNavigationController.viewControllers.first as? NewBikeTourViewController else {
                return
            }
//            guard let editBikeTourViewController = editBikeTourNavigationController.viewControllers.first as? NewBikeTourViewController else {
//                return
//            }
            let indexPath = tableView.indexPathForSelectedRow?.row
            let bikerRoute = bikeRouteStore.getAllBikeRoutes()[indexPath!]
            editBikeTourViewController.setAttributes(bikeRoute: bikerRoute, tableIndex: indexPath!)
           // see http://www.codingexplorer.com/segue-uitableviewcell-taps-swift/))
            
        }
        
    }
    
//    @IBAction func unwind(from segue: UIStoryboardSegue) {
//        guard let bikeTourViewController = segue.source as? NewBikeTourViewController else { return }
//        if segue.identifier == "editBikeTour" {
//       // if driveReviewViewController.reviewType == "editBikeTour" {
//           // bikeTourViewController = bikeTourViewController.reviewBikeCriteria
//        }
//        
//    }
}

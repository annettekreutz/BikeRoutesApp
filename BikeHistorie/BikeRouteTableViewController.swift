//
//  BikeRouteTableViewController.swift
//  BikeHistorie
//
//  Created by Team_iOS on 30.05.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//

import UIKit
import CoreData

class BikeRouteTableViewController : UITableViewController {
    
    let bikeRouteStore = BikeRouteStore()
    var managedObjectContext: NSManagedObjectContext!
    var fetchedResultsController: NSFetchedResultsController<CDBikeRoute>!
    
    // view starting
    override func viewDidLoad() {
        title = "Bike Routes"
        let fetchRequest = NSFetchRequest<CDBikeRoute>(entityName: "CDBikeRoute")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        try? fetchedResultsController.performFetch()
    }

    // Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    // Number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    // write all cells by bike record
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BikeRouteCell", for: indexPath) as! BikeRouteTableViewCell
        let bikeRoute = fetchedResultsController.object(at: indexPath)
        cell.dateLabel.text =  "\( DateFormatter.standard.string(from: bikeRoute.date! as Date))"
        cell.distanceLabel.text =  "\(bikeRoute.distance) km nach: \(bikeRoute.location ?? "")"
        cell.beforeReview.text = "\(CalcCriteria.calcAverage(cdReviewBikeCriteria:bikeRoute.selfConfidenceBefore!))"
        cell.finishReview.text = " \(CalcCriteria.calcAverage(cdReviewBikeCriteria: bikeRoute.selfConfidenceAfter!))"
        
        return cell
    }
    // maybe ... delegetes
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, cellForRowAt indexPath: IndexPath) {
//        switch editingStyle {
//        case .Delete:
//            // remove the deleted item from the model
//            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//            let context:NSManagedObjectContext = appDel.managedObjectContext
//            context.deleteObject(myData[indexPath.row] )
//            myData.removeAtIndex(indexPath.row)
//            do {
//                try context.save()
//            } catch _ {
//            }
//            
//            // remove the deleted item from the `UITableView`
//            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        default:
//            return
//        }
//    }
    
    func infoOfSystemRecord() -> String{
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
    
//    // do delete copy selected record
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        
//        // action one
//        let insertAction = UITableViewRowAction(style: .default, title: "Copy", handler: { (action, indexPath) in
//             print("Copy tapped")
//            
//            let bikeRoute = self.bikeRouteStore.getAllBikeRoutes()[indexPath.row]
//            self.bikeRouteStore.insert(bikeRoute: bikeRoute)
//            tableView.reloadData()
//         })
//         insertAction.backgroundColor = UIColor.blue
//    
//         // action two
//         let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
//            print("Delete tapped")
//            
//            let index = Int(indexPath.row)
//            // remove the item from the data model
//            self.bikeRouteStore.remove(indexOfList: index)
//            
//            // delete the table view row
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData()
//                    })
//        deleteAction.backgroundColor = UIColor.red
//        
//        return [insertAction, deleteAction]
//    }
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
            let indexPath = tableView.indexPathForSelectedRow
            editBikeTourViewController.bikeRoute = fetchedResultsController.object(at: indexPath!)
            editBikeTourViewController.managedObjectContext = managedObjectContext
            
        }
    }
}

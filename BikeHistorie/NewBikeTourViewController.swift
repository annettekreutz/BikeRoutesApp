//
//  NewBikeTourViewController.swift
//  BikeHistorie
//
//  Created by Team_iOS on 30.05.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//
// later: https://www.raywenderlich.com/90971/introduction-mapkit-swift-tutorial

import UIKit
import CoreData

class NewBikeTourViewController: UIViewController {
    @IBOutlet weak var beforeLabel: UILabel!
   
    @IBOutlet weak var finishLabel: UILabel!

    @IBOutlet weak var beforeSlider: UISlider!
    
    @IBOutlet weak var finishSlider: UISlider!
    
    @IBOutlet weak var mileageTextField: UITextField!
    
    @IBOutlet weak var distanceTextField: UITextField!
    
    @IBOutlet weak var tourBreakCountTextField: UITextField!

    @IBOutlet weak var temperaturTextField: UITextField!
   
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var locationTextField: UITextField!
   
    var startReviewBikeCriteria = CDReviewBikeCriteria()
  
    var finishReviewBikeCriteria = CDReviewBikeCriteria()
    
    var bikeRoute: CDBikeRoute?
    
    var managedObjectContext: NSManagedObjectContext!
  
//    var managedObjectContext = UIApplication.shared.delegate as NSManagedObjectContext
//    
    var mapLocation = MapLocation()
    
    // view starting
    // load all saved biker data
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Tour"
        
        datePicker.addTarget(self, action: #selector(datePickerChanged(datePicker:)), for: . valueChanged)
        dateLabel.text = DateFormatter.standard.string(from: datePicker.date)
        let br = self.bikeRoute

        if  br == nil{
             managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
            
//            startReviewBikeCriteria = initReviewBikeCriteria()
//            finishReviewBikeCriteria = initReviewBikeCriteria()
            bikeRoute = initCDReviewBikeCriteria(cdBikeRoute: CDBikeRoute(context: managedObjectContext))

        }
        if let bikeRoute = bikeRoute {
            mileageTextField.text = String( "\(bikeRoute.duration)")
            temperaturTextField.text = String( "\(bikeRoute.temperatur)")
            distanceTextField.text = String( "\(bikeRoute.distance)")
            locationTextField.text = bikeRoute.location
             
            dateLabel.text = DateFormatter.standard.string(from: bikeRoute.date! as Date)
            datePicker.date =   bikeRoute.date! as Date
            tourBreakCountTextField.text = String( "\(bikeRoute.tourBreakCount)")
            beforeSlider.value = 5
            finishSlider.value = 5
            startReviewBikeCriteria = updateReviewBikeCriteria(cdReviewBikeCriteria: bikeRoute.selfConfidenceBefore!)
            
            finishReviewBikeCriteria = updateReviewBikeCriteria(cdReviewBikeCriteria: bikeRoute.selfConfidenceAfter!)
           
            setAndCalcReview(cdReviewBikeCriteria: startReviewBikeCriteria, slider: beforeSlider, label: beforeLabel)
            setAndCalcReview(cdReviewBikeCriteria: finishReviewBikeCriteria, slider: finishSlider, label: finishLabel)
        }
    }
    func initCDReviewBikeCriteria(cdBikeRoute : CDBikeRoute) -> CDBikeRoute{

        // verbinde Daten
        var bikeRoute = cdBikeRoute
        bikeRoute.date = NSDate()
        bikeRoute.distance = Double()
        bikeRoute.temperatur = Double()
        bikeRoute.duration = Double()
        bikeRoute.location =  String("Test")
        bikeRoute.tourBreakCount = Int16()

//        startReviewBikeCriteria = initReviewBikeCriteria(cReviewBikeCriteria: CDReviewBikeCriteria(context: managedObjectContext))
//        finishReviewBikeCriteria = initReviewBikeCriteria(cReviewBikeCriteria: CDReviewBikeCriteria(context: managedObjectContext))
        bikeRoute.selfConfidenceBefore = initReviewBikeCriteria(cReviewBikeCriteria: CDReviewBikeCriteria(context: managedObjectContext))
        bikeRoute.selfConfidenceAfter = initReviewBikeCriteria(cReviewBikeCriteria: CDReviewBikeCriteria(context: managedObjectContext))

 
        return bikeRoute
    }
    func initReviewBikeCriteria(cReviewBikeCriteria: CDReviewBikeCriteria) -> CDReviewBikeCriteria {
        var newSelfConfidence = cReviewBikeCriteria
//        let newSelfConfidence = CDReviewBikeCriteria()
        newSelfConfidence.breaking = Int16(1)
        newSelfConfidence.kurve = Int16(1)
        newSelfConfidence.quickly = Int16(1)
        newSelfConfidence.slowly = Int16(1)
        newSelfConfidence.starting = Int16(1)
        newSelfConfidence.turn = Int16(1)
        return newSelfConfidence
    }
    func updateReviewBikeCriteria(cdReviewBikeCriteria : CDReviewBikeCriteria ) -> CDReviewBikeCriteria {
        let newSelfConfidence = cdReviewBikeCriteria
        // let newSelfConfidence = cdReviewBikeCriteria
        newSelfConfidence.breaking = cdReviewBikeCriteria.breaking
        newSelfConfidence.kurve = cdReviewBikeCriteria.kurve
        newSelfConfidence.quickly = cdReviewBikeCriteria.quickly
        newSelfConfidence.slowly = cdReviewBikeCriteria.slowly
        newSelfConfidence.starting = cdReviewBikeCriteria.starting
        newSelfConfidence.turn = cdReviewBikeCriteria.turn
        return newSelfConfidence
    }

    func setAndCalcReview (cdReviewBikeCriteria : CDReviewBikeCriteria, slider: UISlider, label: UILabel){
        let result = CalcCriteria.calcAverage(cdReviewBikeCriteria : cdReviewBikeCriteria)
        label.text = String(result)
        slider.value = Float(result)
    }
    
    
    func datePickerChanged(datePicker:UIDatePicker) {
        dateLabel.text = DateFormatter.standard.string(from: datePicker.date)
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem){
        back()
    }
    
    func back() {
        navigationController?.presentingViewController?.dismiss(animated: true)
    }
    
    func alert(message: String, messageType : String, returnType : String) {
        
        let alertView = UIAlertController(title: messageType, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: returnType, style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func alert(message: String, messageType : String, returnType : String , textField : UITextField) {
    
        alert(message: message, messageType: messageType, returnType: returnType)
        textField.borderColor = UIColor.red
        textField.backgroundColor = .red
    }
    func alert(message: String, messageType : String, returnType : String , textSlider : UISlider) {
        
        alert(message: message, messageType: messageType, returnType: returnType)
        textSlider.backgroundColor = .red
    }
    
    func resetTextFields() {
         locationTextField.backgroundColor = UIColor.white
         mileageTextField.backgroundColor = UIColor.white
         distanceTextField.backgroundColor = UIColor.white
         tourBreakCountTextField.backgroundColor = UIColor.white
         temperaturTextField.backgroundColor = UIColor.white
         beforeLabel.backgroundColor = UIColor.white
         finishLabel.backgroundColor = UIColor.white
    }
    // validate an save record
    @IBAction func save(_ sender: Any) {
        resetTextFields()
        guard let location = String(locationTextField.text ?? "") else {
            alert(message: "Zielort fehlt!", messageType: "Warnung", returnType: "Ok",textField: locationTextField)
            return }
        if location.isEmpty {
            alert(message: "Zielort fehlt!", messageType: "Warnung", returnType: "Ok",textField: locationTextField)
            return
        }
        guard  (TimeInterval(mileageTextField.text ?? "") != nil) else {
            alert(message: "Kilometerstand fehlt!", messageType: "Warnung", returnType: "Ok", textField: mileageTextField)
            return
        }
        guard (Double(distanceTextField.text ?? "") != nil) else {
            alert(message: "gefahrene Kilomenter fehlen!", messageType: "Warnung", returnType: "Ok",textField: distanceTextField)
            return
        }
        guard Int(tourBreakCountTextField.text ?? "") != nil else {
            alert(message: "Anzahl Pausen fehlen!", messageType: "Warnung", returnType: "Ok",textField: tourBreakCountTextField)
            return
        }
        
         guard Double(temperaturTextField.text ?? "") != nil else {
            alert(message: "Temperatur fehlt!", messageType: "Warnung", returnType: "Ok",textField: temperaturTextField)
            return
        }
        if startReviewBikeCriteria.breaking < 1 ||   startReviewBikeCriteria.quickly < 1 ||
            startReviewBikeCriteria.kurve < 1 ||  startReviewBikeCriteria.slowly < 1 ||
            startReviewBikeCriteria.turn < 1 ||  startReviewBikeCriteria.starting < 1 {
            alert(message:  "Erste Kriterien unvollständig", messageType: "Warnung", returnType: "Ok",textSlider: beforeSlider)
            return
        }
        if finishReviewBikeCriteria.breaking < 1 ||   finishReviewBikeCriteria.quickly < 1 ||
            finishReviewBikeCriteria.kurve < 1 ||  finishReviewBikeCriteria.slowly < 1 ||
            finishReviewBikeCriteria.turn < 1 ||  finishReviewBikeCriteria.starting < 1 {
            alert(message: "Zweite Kriterien unvollständig", messageType: "Warnung", returnType: "Ok",textSlider: finishSlider)
            return
        }
        
        
 
        do {
            try bikeRoute?.managedObjectContext?.save()
            back()
            return
        } catch {
            
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
           // fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            let error = String(describing: nserror)
            let errorInf  = String(describing: nserror.userInfo)
            print("Datensatz wurde nicht gespeichert: " +   errorInf  + " Err: " + error)
//            alert(message: "Datensatz wurde nicht gespeichert: ", messageType: error + " " + errorInf , returnType: "OK" )
            
            //return
        }
//        do {
//            bikeRoute?.managedObjectContext?.insert(bikeRoute!)
//            back()
//        } catch {
//            let nserror = error as NSError
//            let errorInf  = String(describing: nserror.userInfo)
//            print("Datensatz wurde nicht gespeichert: " +   errorInf )
//        }
    }

    @IBAction func goBack(_ sender: Any?) {
        performSegue(withIdentifier: "unwindFromReview", sender: self)
    }
    // transport record in edit view or in map view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startIdent" {
            guard let driveReviewViewController = segue.destination as? DriveReviewViewController else { return }
            driveReviewViewController.setParams(reviewBikeCriteria: startReviewBikeCriteria, reviewType: "startIdent")
           // print(startReviewBikeCriteria.breaking)
        }
        if segue.identifier == "finishIdent" {
            guard let driveReviewViewController = segue.destination as? DriveReviewViewController else { return }
            driveReviewViewController.setParams(reviewBikeCriteria: finishReviewBikeCriteria, reviewType: "finishIdent")
        }
        if segue.identifier == "mapIdent" {
            guard let driveMapViewController = segue.destination as? DriveMapViewController else { return }
            mapLocation.location=locationTextField.text!
            driveMapViewController.mapLocation=mapLocation
        }
    }
   
  
    
    func setLocation (){
          self.locationTextField.text = mapLocation.location
    }
    func unwindDriveMap(from segue: UIStoryboardSegue) {
        guard let driveMapViewController = segue.source as? DriveMapViewController else { return }
      
        if segue.identifier == "mapIdent" {
            mapLocation = driveMapViewController.mapLocation
        }
    }
     
    // take data from edit view
    @IBAction func unwind(from segue: UIStoryboardSegue) {
        unwindDriveMap (from: segue)
        guard let driveReviewViewController = segue.source as? DriveReviewViewController else { return }
        if driveReviewViewController.reviewType == "startIdent" {
            startReviewBikeCriteria = driveReviewViewController.reviewBikeCriteria
            setAndCalcReview(cdReviewBikeCriteria : startReviewBikeCriteria,slider: beforeSlider, label: beforeLabel)
        }
        else if driveReviewViewController.reviewType == "finishIdent" {
            finishReviewBikeCriteria = driveReviewViewController.reviewBikeCriteria
             setAndCalcReview(cdReviewBikeCriteria : finishReviewBikeCriteria,slider: finishSlider,label: finishLabel)
        }
    }
}

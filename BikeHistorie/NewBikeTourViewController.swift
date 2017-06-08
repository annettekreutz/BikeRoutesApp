//
//  NewBikeTourViewController.swift
//  BikeHistorie
//
//  Created by Team_iOS on 30.05.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//
// later: https://www.raywenderlich.com/90971/introduction-mapkit-swift-tutorial

import UIKit

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
    
    
    var startReviewBikeCriteria = ReviewBikeCriteria()
    
    var finishReviewBikeCriteria = ReviewBikeCriteria()
    
    var tableIndex = Int(-1)
    
    var bikeRoute: BikeRoute?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(isEditing){
            print ("Modus Eding")
        }
        datePicker.addTarget(self, action: #selector(datePickerChanged(datePicker:)), for: . valueChanged)
        dateLabel.text = DateFormatter.standard.string(from: datePicker.date)

        if let bikeRoute = self.bikeRoute {
            mileageTextField.text = String( "\(bikeRoute.driveDuration)")
            temperaturTextField.text = String( "\(bikeRoute.temperatur)")
            distanceTextField.text = String( "\(bikeRoute.distance)")
            
            // DateFormatter.standard.string(from: bikeRoute.date)
            
            dateLabel.text = DateFormatter.standard.string(from: bikeRoute.date)
            datePicker.date =   bikeRoute.date
            tourBreakCountTextField.text = String( "\(bikeRoute.tourBreakCount)")
            
            startReviewBikeCriteria.mapEnumCriteria = bikeRoute.startCriteria.mapEnumCriteria
            finishReviewBikeCriteria.mapEnumCriteria = bikeRoute.finishCriteria.mapEnumCriteria
        }

    }
    
    func setAttributes(bikeRoute : BikeRoute, tableIndex : Int){
 
        self.tableIndex = tableIndex
        self.bikeRoute = bikeRoute
    }
    
    func datePickerChanged(datePicker:UIDatePicker) {
        
        let strDate = DateFormatter.standard.string(from: datePicker.date)
//        let someString = "11.12.2004"
//        if let newDate = DateFormatter.standard.date(from: someString) {
//            //
//           let newDt = newDate
//        }
        dateLabel.text = strDate
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelButton(_ sender: UIBarButtonItem){
        back()
    }
    func back() {
        navigationController?.presentingViewController?.dismiss(animated: true)
        
    }
    
    func alert(message: String, messageType : String, returnType : String , uITextField : UITextField) {
    //    uITextField.borderStyle.rawValue = UITextBorderStyleNone
        let alertView = UIAlertController(title: messageType, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: returnType, style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    @IBAction func save(_ sender: Any) {
       //   mileageTextField.borderStyle.rawValue = UITextBorderStyleNone
        guard let location = String(locationTextField.text ?? "") else {
            alert(message: "Zielort fehlt!", messageType: "Warnung", returnType: "Ok",uITextField: locationTextField)
            return }
        if location.isEmpty {
            alert(message: "Zielort fehlt!", messageType: "Warnung", returnType: "Ok",uITextField: locationTextField)
            return
        }
   
        guard let driveDuration = TimeInterval(mileageTextField.text ?? "") else {
            alert(message: "Kilometerstand fehlt!", messageType: "Warnung", returnType: "Ok", uITextField: mileageTextField)
            return }
  
        
        guard let distance = Double(distanceTextField.text ?? "") else {
            alert(message: "gefahrene Kilomenter fehlen!", messageType: "Warnung", returnType: "Ok",uITextField: distanceTextField)
            return }
        guard let tourBreakCount = Int(tourBreakCountTextField.text ?? "") else {
            alert(message: "Anzahl Pausen fehlen!", messageType: "Warnung", returnType: "Ok",uITextField: distanceTextField)
            return }
        
        guard let temperatur = Double(temperaturTextField.text ?? "") else { return }
        if  startReviewBikeCriteria.mapEnumCriteria.count < 6  {
            alert(message:  "Erste Kriterien unvollständig", messageType: "Warnung", returnType: "Ok",uITextField: distanceTextField)
            return }
        if   finishReviewBikeCriteria.mapEnumCriteria.count < 6  {
            alert(message: "Zweite Kriterien unvollständig", messageType: "Warnung", returnType: "Ok",uITextField: distanceTextField)
            return }
        
        let bikeRoute = BikeRoute(driveDuration: driveDuration,location:location, distance: distance, tourBreakCount: tourBreakCount, date: datePicker.date, temperatur: temperatur, startCriteria: startReviewBikeCriteria, finishCriteria: finishReviewBikeCriteria)
        
        let br = BikeRouteStore()
        if(tableIndex == -1){
        // TODO recherch tableIndex and save an edited object
            br.store(bikeRoute: bikeRoute)
        } else {
            br.store(bikeRoute: bikeRoute, tabIndex: tableIndex)
            tableIndex = -1
        }
      //  print(bikeRoute)
        back()
    }
    @IBAction func goBack(_ sender: Any?) {
        performSegue(withIdentifier: "unwindFromReview", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startIdent" {
            guard let driveReviewViewController = segue.destination as? DriveReviewViewController else { return }
            driveReviewViewController.setParams(reviewBikeCriteria: startReviewBikeCriteria, reviewType: "startIdent")
          
        }
        if segue.identifier == "finishIdent" {
            guard let driveReviewViewController = segue.destination as? DriveReviewViewController else { return }
            
            driveReviewViewController.setParams(reviewBikeCriteria: finishReviewBikeCriteria, reviewType: "finishIdent")
            
        }
        if segue.identifier == "mapIdent" {
            guard let driveMapViewController = segue.destination as? DriveMapViewController else { return }
          //  driveMapViewController.testLabel.text = "test"
          //  driveMapViewController.setParam( )
//            driveMapViewController.setParams(reviewBikeCriteria: finishReviewBikeCriteria, reviewType: "finishIdent")
            
        }
     
    }
    func calcReview (reviewBikeCriteria :ReviewBikeCriteria, slider: UISlider, label: UILabel){
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
        label.text = String(result)
        //print( result)
        slider.value = Float(result)
    }
    @IBAction func unwind(from segue: UIStoryboardSegue) {
        guard let driveReviewViewController = segue.source as? DriveReviewViewController else { return }
      //  if segue.identifier == "startIdent" {
        if driveReviewViewController.reviewType == "startIdent" {
            startReviewBikeCriteria = driveReviewViewController.reviewBikeCriteria
            calcReview(reviewBikeCriteria : startReviewBikeCriteria,slider: beforeSlider, label: beforeLabel)
        }
         if segue.identifier == "finishIdent" {
            finishReviewBikeCriteria = driveReviewViewController.reviewBikeCriteria
             calcReview(reviewBikeCriteria : finishReviewBikeCriteria,slider: finishSlider,label: finishLabel)
        } else {// editBikeTour
            // do nothing
        }
        
    }
}

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
    
    var mapLocation = MapLocation()
    
//    var weather = WeatherGetter()
//   
    // view starting
    // load all saved biker data
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Tour"
        
//        let location = locationTextField.text
//        //let location = mapLocation.location
//        weather.getWeather(city: location!, callback: { weather in
//            DispatchQueue.main.async {
//                self.temperaturTextField.text = weather
//            }
//            
//        })
//       // temperaturTextField.text = weather.wetter
        
        if(isEditing){
            print ("Modus Eding")
        }
        datePicker.addTarget(self, action: #selector(datePickerChanged(datePicker:)), for: . valueChanged)
        dateLabel.text = DateFormatter.standard.string(from: datePicker.date)

        if let bikeRoute = self.bikeRoute {
            mileageTextField.text = String( "\(bikeRoute.driveDuration)")
            temperaturTextField.text = String( "\(bikeRoute.temperatur)")
            distanceTextField.text = String( "\(bikeRoute.distance)")
            locationTextField.text = bikeRoute.location
             
            dateLabel.text = DateFormatter.standard.string(from: bikeRoute.date)
            datePicker.date =   bikeRoute.date
            tourBreakCountTextField.text = String( "\(bikeRoute.tourBreakCount)")
            
            startReviewBikeCriteria.mapEnumCriteria = bikeRoute.startCriteria.mapEnumCriteria
            finishReviewBikeCriteria.mapEnumCriteria = bikeRoute.finishCriteria.mapEnumCriteria
            
            setAndCalcReview(reviewBikeCriteria: bikeRoute.startCriteria, slider: beforeSlider, label: beforeLabel)
            setAndCalcReview(reviewBikeCriteria: bikeRoute.finishCriteria, slider: finishSlider, label: finishLabel)
            mapLocation.location = bikeRoute.location
        }

    }
   
    func setAttributes(bikeRoute : BikeRoute, tableIndex : Int){
        self.tableIndex = tableIndex
        self.bikeRoute = bikeRoute
    }
    
    func datePickerChanged(datePicker:UIDatePicker) {
        dateLabel.text = DateFormatter.standard.string(from: datePicker.date)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
        
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
        guard let driveDuration = TimeInterval(mileageTextField.text ?? "") else {
            alert(message: "Kilometerstand fehlt!", messageType: "Warnung", returnType: "Ok", textField: mileageTextField)
            return
        }
        guard let distance = Double(distanceTextField.text ?? "") else {
            alert(message: "gefahrene Kilomenter fehlen!", messageType: "Warnung", returnType: "Ok",textField: distanceTextField)
            return
        }
        guard let tourBreakCount = Int(tourBreakCountTextField.text ?? "") else {
            alert(message: "Anzahl Pausen fehlen!", messageType: "Warnung", returnType: "Ok",textField: tourBreakCountTextField)
            return
        }
        
        guard let temperatur = Double(temperaturTextField.text ?? "") else {
            alert(message: "Temperatur fehlt!", messageType: "Warnung", returnType: "Ok",textField: temperaturTextField)
            return
        }
        if  startReviewBikeCriteria.mapEnumCriteria.count < 6  {
            alert(message:  "Erste Kriterien unvollständig", messageType: "Warnung", returnType: "Ok",textSlider: beforeSlider)
            return
        }
        if   finishReviewBikeCriteria.mapEnumCriteria.count < 6  {
            alert(message: "Zweite Kriterien unvollständig", messageType: "Warnung", returnType: "Ok",textSlider: finishSlider)
            return
        }
        let bikeRoute = BikeRoute(driveDuration: driveDuration,location:location, distance: distance, tourBreakCount: tourBreakCount, date: datePicker.date, temperatur: temperatur, startCriteria: startReviewBikeCriteria, finishCriteria: finishReviewBikeCriteria)
        let br = BikeRouteStore()
        if(tableIndex == -1){
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
    // transport record in edit view or in map view
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
            mapLocation.location=locationTextField.text!
        }
    }
   
    func setAndCalcReview (reviewBikeCriteria : ReviewBikeCriteria, slider: UISlider, label: UILabel){
        let result = CalcCriteria.calcAverage(reviewBikeCriteria: reviewBikeCriteria)
        label.text = String(result)
        slider.value = Float(result)
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
            setAndCalcReview(reviewBikeCriteria : startReviewBikeCriteria,slider: beforeSlider, label: beforeLabel)
        }
        else if driveReviewViewController.reviewType == "finishIdent" {
            finishReviewBikeCriteria = driveReviewViewController.reviewBikeCriteria
             setAndCalcReview(reviewBikeCriteria : finishReviewBikeCriteria,slider: finishSlider,label: finishLabel)
        }
    }
}

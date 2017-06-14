//
//  DriveReviewViewController.swift
//  BikeHistorie
//
//  Created by Team_iOS on 31.05.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//

import UIKit

class DriveReviewViewController: UIViewController {
    
    var reviewType = String()
    
    var reviewBikeCriteria = CDReviewBikeCriteria()
    //ReviewBikeCriteria()
   
    
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var slowlyLabel: UILabel!
    
    @IBOutlet weak var quicklyLabel: UILabel!
    
    @IBOutlet weak var kurveLabel: UILabel!
    
    @IBOutlet weak var startingLabel: UILabel!
    
    @IBOutlet weak var breakingLabel: UILabel!
    
    @IBOutlet weak var slowlySlider: UISlider!
    
    @IBOutlet weak var quicklySlider: UISlider!

    @IBOutlet weak var turnSlider: UISlider!
    
    @IBOutlet weak var kurveSlider: UISlider!
    
    @IBOutlet weak var startSlider: UISlider!
   
    @IBOutlet weak var breakSlider: UISlider!
    
    // view starting
    // init and update view
    override func viewDidLoad() {
        navigationItem.title = "Tour Review"
        initParams()
        updateParams()
        super.viewDidLoad()
    }
    
    // cache params from edit view
    func setParams( reviewBikeCriteria: CDReviewBikeCriteria, reviewType : String) {
        self.reviewBikeCriteria = reviewBikeCriteria
        self.reviewType = reviewType
    }
    
    // base function for slider and label update
    func updateUiParams(uiSlider: UISlider, uiILabel : UILabel, destination :Int16 ) {
        let destinationText = String(describing: destination)
        let destinationNumber =  destination
        uiILabel.text = destinationText
        uiSlider.value = Float(destinationNumber)
    }
    func initParams() {
        updateUiParams(uiSlider: turnSlider, uiILabel: turnLabel, destination: 0)
        updateUiParams(uiSlider: kurveSlider, uiILabel: kurveLabel, destination: 0)
        updateUiParams(uiSlider: kurveSlider, uiILabel: kurveLabel, destination: 0)
        updateUiParams(uiSlider: startSlider, uiILabel: startingLabel, destination: 0)
        updateUiParams(uiSlider: breakSlider, uiILabel: breakingLabel, destination: 0)
        updateUiParams(uiSlider: slowlySlider, uiILabel: slowlyLabel, destination: 0)
        updateUiParams(uiSlider: quicklySlider, uiILabel: quicklyLabel, destination: 0)
        
    }
    // update slilders and label by params in this view
    func updateParams() {
        let rev = reviewBikeCriteria
        let ret = rev.turn
        updateUiParams(uiSlider: turnSlider, uiILabel: turnLabel, destination: ret)
        updateUiParams(uiSlider: kurveSlider, uiILabel: kurveLabel,destination:  reviewBikeCriteria.kurve)
        updateUiParams(uiSlider: startSlider, uiILabel: startingLabel,destination:   reviewBikeCriteria.starting)
       
        updateUiParams(uiSlider: breakSlider, uiILabel: breakingLabel,destination:  reviewBikeCriteria.breaking)
        updateUiParams(uiSlider: startSlider, uiILabel: startingLabel,destination: reviewBikeCriteria.starting)
        updateUiParams(uiSlider: slowlySlider, uiILabel: slowlyLabel,destination:  reviewBikeCriteria.slowly)
       
        updateUiParams(uiSlider: quicklySlider, uiILabel: quicklyLabel,destination:   reviewBikeCriteria.quickly)
        
    }
    // base function for update class attributes by slider and label
    func driveSliderValueChange(_ sender: UISlider,   uiILabel : UILabel!) -> Int16 {
       
        let currentValue = Int(sender.value)
        uiILabel.text = String(currentValue)
     //reviewBikeCriteria.mapEnumCriteria [enumCriteria] = EnumStar(rawValue: currentValue)
        let result = Int16(sender.value)
        return result
   
    }
    @IBAction func slowlyDriveSliderValueChange(_ sender: UISlider) {
        reviewBikeCriteria.slowly =  driveSliderValueChange(sender, uiILabel: slowlyLabel)
    }
    
    @IBAction func quicklyDriveSliderValueChange(_ sender: UISlider) {
        reviewBikeCriteria.quickly =  driveSliderValueChange(sender, uiILabel: quicklyLabel)
    }
    
    
    @IBAction func turnDriveSliderValueChange(_ sender: UISlider) {
         reviewBikeCriteria.turn =  driveSliderValueChange(sender, uiILabel: turnLabel)
    }
    
    @IBAction func kurveDriveSliderValueChange(_ sender: UISlider) {
          reviewBikeCriteria.kurve =  driveSliderValueChange(sender, uiILabel: kurveLabel)
      }
    
    
    @IBAction func startingDriveSliderValueChange(_ sender: UISlider){
        reviewBikeCriteria.starting =  driveSliderValueChange(sender, uiILabel: startingLabel)
    }
    
    
    @IBAction func breakingDriveSliderValueChange(_ sender: UISlider){
        reviewBikeCriteria.breaking =  driveSliderValueChange(sender, uiILabel: breakingLabel)
    }
   
    
    override func viewWillDisappear(_ animated: Bool) {
        performSegue(withIdentifier: "unwindFromReview", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

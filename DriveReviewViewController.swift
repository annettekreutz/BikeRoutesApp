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
    
    var reviewBikeCriteria = ReviewBikeCriteria()
    
    
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
    
    func setParams( reviewBikeCriteria: ReviewBikeCriteria, reviewType : String) {
        self.reviewBikeCriteria = reviewBikeCriteria
        self.reviewType = reviewType
    }
    func updateUiParams(uiSlider: UISlider, uiILabel : UILabel, destination :Int ) {
        let destinationText = String(describing: destination)
        let destinationNumber =  destination
        uiILabel.text = destinationText
        uiSlider.value = Float(destinationNumber)
       
        
    }
    func updateParams() {
        
        for bike in reviewBikeCriteria.mapEnumCriteria {
            let enumCriteria = bike.key

            let destinationCrit  = reviewBikeCriteria.mapEnumCriteria[enumCriteria]
            let destination : Int = destinationCrit!.rawValue

            switch enumCriteria {
            case EnumCriteria.turn:
                updateUiParams(uiSlider: turnSlider, uiILabel: turnLabel, destination: destination)

            case EnumCriteria.kurve:
                  updateUiParams(uiSlider: kurveSlider, uiILabel: kurveLabel,destination: destination)
                
            case EnumCriteria.starting:
                     updateUiParams(uiSlider: startSlider, uiILabel: startingLabel, destination: destination)
  
            case EnumCriteria.breaking:
                    updateUiParams(uiSlider: breakSlider, uiILabel: breakingLabel,  destination: destination)
          
            case EnumCriteria.slowly:

                updateUiParams(uiSlider: slowlySlider, uiILabel: slowlyLabel,  destination: destination)
           
            case EnumCriteria.quickly:
                updateUiParams(uiSlider: quicklySlider, uiILabel: quicklyLabel, destination: destination)
               
            default: break
                
            }
            
        }
        
    }
 
    func driveSliderValueChange(_ sender: UISlider, enumCriteria:EnumCriteria, uiILabel : UILabel!) {
       
        let currentValue = Int(sender.value)
        uiILabel.text = String(currentValue)
        reviewBikeCriteria.mapEnumCriteria [enumCriteria] = EnumStar(rawValue: currentValue)
   
    }
    @IBAction func slowlyDriveSliderValueChange(_ sender: UISlider) {
        
        driveSliderValueChange(sender,enumCriteria: EnumCriteria.slowly,uiILabel: slowlyLabel)
    }
    
    @IBAction func quicklyDriveSliderValueChange(_ sender: UISlider) {
        driveSliderValueChange(sender,enumCriteria: EnumCriteria.quickly,uiILabel: quicklyLabel)

    }
    
    
    @IBAction func turnDriveSliderValueChange(_ sender: UISlider) {
          driveSliderValueChange(sender,enumCriteria: EnumCriteria.turn,uiILabel: turnLabel)

    }
    
    @IBAction func kurveDriveSliderValueChange(_ sender: UISlider) {
         driveSliderValueChange(sender,enumCriteria: EnumCriteria.kurve,uiILabel: kurveLabel)

    }
    
    
    @IBAction func startingDriveSliderValueChange(_ sender: UISlider) {
          driveSliderValueChange(sender,enumCriteria: EnumCriteria.starting,uiILabel: startingLabel)

    }
    
    
    @IBAction func breakingDriveSliderValueChange(_ sender: UISlider) {
        driveSliderValueChange(sender,enumCriteria: EnumCriteria.breaking,uiILabel: breakingLabel)

    }
    
    override func viewDidLoad() {
        updateParams()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        performSegue(withIdentifier: "unwindFromReview", sender: self)
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
}

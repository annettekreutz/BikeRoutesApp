//
//  DriveReviewViewController.swift
//  BikeHistorie
//
//  Created by Team_iOS on 31.05.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//

import UIKit

class DriveReviewViewController: UIViewController {
    //mapEnumCriteria[.langsam] = .star6
    
    //var mapDriveCriteria = [EnumCriteria: EnumStar]()
    
    var reviewBikeCriteria = ReviewBikeCriteria()
    
    @IBOutlet weak var slowlyLabel: UILabel!
    
    @IBOutlet weak var quicklyLabel: UILabel!
    
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var kurveLabel: UILabel!
    
    @IBOutlet weak var startingLabel: UILabel!
    
    @IBOutlet weak var breakingLabel: UILabel!
    
    func driveSliderValueChange(_ sender: UISlider, enumCriteria:EnumCriteria, uiILabel : UILabel!) {
       
        let currentValue = Int(sender.value)
        uiILabel.text = String(currentValue)
        reviewBikeCriteria.mapEnumCriteria [enumCriteria] = EnumStar(rawValue: currentValue)
      //  mapDriveCriteria   [enumCriteria] = EnumStar(rawValue: currentValue)
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

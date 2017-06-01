//
//  ViewController.swift
//  BikeHistorie
//
//  Created by Team_iOS on 26.05.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
 
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    
    @IBAction func unwind(from segue: UIStoryboardSegue) {
        //guard let second = segue.source as? SecondViewController else { return }
        //////guard let first = segue.destination as? FirstViewController else { return }
        
        ////first.textField.text = "Bin wieder da!"
        
        //second.text = first.textField.text
    }
}


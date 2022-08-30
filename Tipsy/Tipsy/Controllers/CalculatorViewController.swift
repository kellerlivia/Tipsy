//
//  ViewController.swift
//  Tipsy
//
//  Created by Livia Carvalho Keller on 30/08/22.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var splitPeopleNumber = 2
    var billTotal = 0.0
    var final = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        // run the true
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        //the button selected is true
        sender.isSelected = true
        
        // variable to store the text
        let buttonTitle = sender.currentTitle!
        // dropLast returns empty set
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        // converting text to double
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
                                                 
        tip = buttonTitleAsANumber / 100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        splitPeopleNumber = Int(sender.value)
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        // variable to store the text
        let bill = billTextField.text!
        if bill != "" {
            // converting text to double
            billTotal = Double(bill)!
            // calculating the result
            let result = billTotal * (1 + tip) / Double(splitPeopleNumber)
            // formatting the result
            final = String(format: "%.2f", result)
            // calling the result screen
            performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    // screen transition
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            // variable that saves the destination
            let destination = segue.destination as! ResultsViewController
            // what will be displayed
            destination.result = final
            destination.split = splitPeopleNumber
            destination.tip = Int(tip * 100)
        }
    }

}


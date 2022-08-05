//
//  ViewController.swift
//  tip
//
//  Created by Kevin Sekuj on 12/13/20.

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var partySizeUIStepper: UIStepper!
    @IBOutlet weak var partySizeUILabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initializing objects and UI
        billAmountTextField.attributedPlaceholder = NSAttributedString(string: "0", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        totalLabel.adjustsFontSizeToFitWidth = true
        tipPercentageLabel.adjustsFontSizeToFitWidth = true
        
        partySizeUIStepper.layer.cornerRadius = 10.0
        partySizeUILabel.text = "1"
        partySizeUIStepper.value = 1
        
    }
    
    @IBAction func onTap(_ sender: Any) {
    }
    
    // method for keypad numbers, assigning each number to a tag of n+1
    // each keypad button press sends a tag-1, e.g. pressing 7 sends tag8 - 1
    @IBAction func keyPad(_ sender: UIButton) {
        billAmountTextField.text = billAmountTextField.text! + String(sender.tag-1)
        calculateTip(keyPad)
    }
    
    // backspace button functionality, where if the count of the UITextLabel is less than 1
    // (no numbers on screen) then the label becomes blank. If UITextLabel count > 1, then backspace
    // deletes the tailing integer by calling remove on the array index before the endIndex (i.e the last
    // number on screen)
    @IBAction func backspace(_ sender: UIButton) {
        if billAmountTextField.text!.count <= 1 {
            billAmountTextField.text = ""
            billAmountTextField.placeholder = "0"
        } else {
            billAmountTextField.text!.remove(at: billAmountTextField.text!.index(before: billAmountTextField.text!.endIndex))
        }
    }
    // decimal button functionality where a decimal keypress when no numbers are on screen inputs a "0." string in which
    // all further user input button presses follow. Otherise, the decimal follows the last input number, unless there is already
    // a decimal present.
    @IBAction func decimal(_ sender: UIButton) {
        if billAmountTextField.text!.count < 1 {
            billAmountTextField.text = "0."
        } else {
            if billAmountTextField.text!.count >= 1 && billAmountTextField.text!.contains(".") == false {
                billAmountTextField.text! += "."
            }
            else if billAmountTextField.text!.contains(".") {
                billAmountTextField.text = billAmountTextField.text
            }
        }
    }
    // reset button
    @IBAction func reset(_ sender: UIButton) {
        partySizeUIStepper.value = 1
        partySizeUILabel.text = String(partySizeUIStepper.value)
        billAmountTextField.text = ""
        billAmountTextField.placeholder = "0"
        tipControl.selectedSegmentIndex = 0
        calculateTip(reset)
    }
    // UIStepper functionality
    @IBAction func partySizeValue(_ sender: UIButton) {
        partySizeUILabel.text = String(partySizeUIStepper.value)
    }
    
    // method to calculate and display tip, accounting for size of party
    @IBAction func calculateTip(_ sender: Any) {
        // get initial bill amount and calculate tips
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercentages = [0.15, 0.18, 0.2]
        // calculate tip and total
        let tip = (bill * tipPercentages[tipControl.selectedSegmentIndex]) / partySizeUIStepper.value
        let total = (bill / partySizeUIStepper.value) + tip
        
        tipPercentageLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}

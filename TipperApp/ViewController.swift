//
//  ViewController.swift
//  TipperApp
//
//  Created by Mac on 05.02.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var totalBillTextField: UITextField!
    @IBOutlet weak var tipTextField: UITextField!
    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var splitlabel: UILabel!
    @IBOutlet weak var tipSplitTextField: UITextField!
    @IBOutlet weak var totalSplitTextField: UITextField!
    
    var totalBill: Double? {
        return Double(totalBillTextField.text!)
    }
    
    var tipPercentage: Double = 0.1
    var numberOfPeople: Double = 1.0
    private var formater: NumberFormatter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
        totalBillTextField.delegate = self
        formater = NumberFormatter()
        formater.numberStyle = NumberFormatter.Style.decimal
        formater.minimum = 0
    }

    @IBAction func tipSliderChanged(_ sender: UISlider) {
        let sliderValue = Int(sender.value)
        tipPercentLabel.text = "\(sliderValue)%"
        tipPercentage = Double(Int(sender.value)) * 0.01
        updateUI()
    }
    
    @IBAction func splitStepperChanged(_ sender: UIStepper) {
        let stepperValue = Int(sender.value)
        splitlabel.text = "\(stepperValue)"
        numberOfPeople = Double(stepperValue)
        updateUI()
    }
    
    @IBAction func totalBillTextFieldChanged(_ sender: UITextField) {
        updateUI()
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        totalBillTextField.resignFirstResponder()
    }
    
    func updateUI() {
        if let totalBill = self.totalBill {
            tipTextField.text = String(format: "%.2f", (totalBill * tipPercentage))
            totalTextField.text = String(format: "%.2f", (totalBill * tipPercentage) + totalBill)
            tipSplitTextField.text = String(format: "%.2f", (totalBill * tipPercentage) / numberOfPeople)
            totalSplitTextField.text = String(format: "%.2f", ((totalBill * tipPercentage) + totalBill) / numberOfPeople)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn shouldChangeCharacterInRange: NSRange, replacementString string: String) -> Bool {
        return formater.number(from: "\(textField.text ?? "0.0")\(string)") != nil
    }
    
}


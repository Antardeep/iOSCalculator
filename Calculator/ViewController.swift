//
//  ViewController.swift
//  Calculator
//
//  Created by Guest User on 2019-01-17.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var display: UILabel!
    var userIsTyping = false
    
    @IBAction func digit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let currentText = display.text!
        if userIsTyping{
            display.text = currentText + digit
        }
        else{
            display.text = digit
            userIsTyping = true
        }
    }
    
    var displayValue:Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = Brain()
    
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsTyping{
            brain.setOperand(_operand: displayValue)
            userIsTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle{
            
            brain.performOperation(_symbol: mathematicalSymbol)
        }
        if let result = brain.result{
            displayValue = result
        }
    }
}


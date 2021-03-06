//
//  ViewController.swift
//  Calculator
//
//  Created by Jason Aylward on 4/23/15.
//  Copyright (c) 2015 Jason Aylward. All rights reserved.
//

import UIKit

class ViewController : UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingNumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber {
            enter()
        }
        switch operation {
        case "×": performOperation({ $0 * $1 })
        case "÷": performOperation({ $1 / $0 })
        case "+": performOperation({ $0 + $1 })
        case "−": performOperation({ $1 - $0 })
        case "√": performOperation({ sqrt($0) })
        default:  break
            
        }
    }
    private func performOperation(operation: Double -> Double){
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


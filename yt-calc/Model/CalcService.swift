//
//  CalcService.swift
//  yt-calc
//
//  Created by ake11a on 07.09.2022.
//

import Foundation

class CalcService {
    
    // MARK: Properties
    var isRunning = true
    var currentNumber = "0"
    var digit1 = 0.0
    var digit2 = 0.0
    var result = ""
    var currentOperation  = Operations.noAction
    var displayView: ViewController
    
    init(displayView: ViewController) {
        self.displayView = displayView
    }
    
    // MARK: Methods
    
    func numberAction(number: Int) {
        if currentNumber != "0" {
            currentNumber.append(String(number))
            displayView.updateDisplay(text: currentNumber)
        } else {
            currentNumber = String(number)
            displayView.updateDisplay(text: currentNumber)
        }
    }
    
    func makeCalculation(operation: Operations) {
        if currentOperation != .noAction {
            if currentNumber != "" {
                digit2 = Double(currentNumber) ?? 0
                switch operation {
                case .addition:
                    result = String(digit1 + digit2)
                case .substraction:
                    result = String(digit1 - digit2)
                case .multiplication:
                    result = String(digit1 * digit2)
                case .division:
                    result = String(digit1 / digit2)
                default:
                    result = ""
                }
                
                digit1 = Double(result)!
                if Double(result)!.truncatingRemainder(dividingBy: 1) == 0
                {
                    result = String(Int(Double(result)!))
                }
                currentNumber = result
                displayView.updateDisplay(text: currentNumber)
                currentOperation = .noAction
                
            }
        } else {
            digit1 = Double(currentNumber) ?? 0.0
            currentNumber = ""
            displayView.updateDisplay(text: currentNumber)
            currentOperation = operation
        }

    }
    
    func addition() {
        makeCalculation(operation: .addition)
    }
    
    func substraction() {
        makeCalculation(operation: .substraction)
    }
    
    func multiplication() {
        makeCalculation(operation: .multiplication)
    }
    
    func division() {
        makeCalculation(operation: .division)
    }
    
    func makeResult() {
        makeCalculation(operation: currentOperation)
    }
    
    func acAction() {
        currentNumber = ""
        digit1 = 0.0
        digit2 = 0.0
        result = ""
        currentOperation  = Operations.noAction
        
        displayView.updateDisplay(text: "0")
    }
    
    func changeSign() {
        var temp = currentNumber
        if temp.contains("-") {
            let sign = ["-"]
            temp = String(temp.filter { !sign.contains(String($0)) })
            displayView.updateDisplay(text: temp)
            currentNumber = temp
        } else {
            temp = "-" + currentNumber
            displayView.updateDisplay(text: temp)
            currentNumber = temp
        }
    }
    
    func percent() {
        currentNumber = String(Double(currentNumber)! / 100)
        displayView.updateDisplay(text: currentNumber)
        result = currentNumber
        digit1 = Double(result)!
    }
    
    func dot() {
        if currentNumber.contains(".") {
            return
        } else {
            currentNumber += "."
            displayView.updateDisplay(text: currentNumber)
        }
    }
    
}

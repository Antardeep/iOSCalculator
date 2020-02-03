//
//  Brain.swift
//  Calculator
//
//  Created by Guest User on 2019-01-17.
//  Copyright © 2019 Guest User. All rights reserved.
//

import Foundation

private var binaryOperation: BinaryOperation?

private struct BinaryOperation{
    let function: (Double,Double)->Double
    let Operand1: Double
    func perform(with operand2: Double)->Double{
        return function(Operand1, operand2)
    }
}

func changesign(Operand: Double)->Double{
    return -Operand
}
func multiply(op1:Double,op2:Double)->Double{
    return op1*op2
}
func addition(op1:Double,op2:Double)->Double{
    return op1+op2
}
func subraction(op1:Double,op2:Double)->Double{
    return op1-op2
}
func division(op1:Double,op2:Double)->Double{
    return op1/op2
}
func half(op: Double)-> Double{
    return (1/op)
}
func sqr(op: Double)-> Double{
    return(op*op)
}
func cube(op: Double)-> Double{
    return(op*op*op)
}
func percent(op: Double)->Double{
    return(op/100)
}
func fact(op: Double)-> Double{
    let n = Int(op)
    var f: Int = 1
    for i in 1...n{
        f = f * i
        
    }
    return(Double(f))
}
func mod(op: Double)-> Double{
    if(op < 0){
        return(-op)
    }
    else{
        return(op)
    }
}
func powerFun(op1: Double,op2: Double)->Double{
    return(pow(op1, op2))
}
func tenPower(op: Double)-> Double{
    return(pow(10, op))
}
func backSpace(op: Double)->Double{
    return(op)
}
struct Brain{
    private var accumulator:Double?
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var Operations: Dictionary<String,Operation> = [
        "π":Operation.constant(Double.pi),
        "e":Operation.constant(M_E),
        "√":Operation.unaryOperation(sqrt),
        "cos":Operation.unaryOperation(cos),
        "sin":Operation.unaryOperation(sin),
        "tan":Operation.unaryOperation(tan),
        "log":Operation.unaryOperation(log),
        "1/x":Operation.unaryOperation(half),
        "±":Operation.unaryOperation(changesign),
        "x^2":Operation.unaryOperation(sqr),
        "x^3":Operation.unaryOperation(cube),
        "%":Operation.unaryOperation(percent),
        "x!":Operation.unaryOperation(fact),
        "|x|":Operation.unaryOperation(mod),
        "AC":Operation.constant(0),
        /*"back":Operation.unaryOperation(backSpace),*/
        "*":Operation.binaryOperation(multiply),
        "+":Operation.binaryOperation(addition),
        "-":Operation.binaryOperation(subraction),
        "/":Operation.binaryOperation(division),
        "=":Operation.equals,
        "XpowY":Operation.binaryOperation(powerFun),
        "10powX":Operation.unaryOperation(tenPower)
    ]
    
    mutating func performOperation(_symbol:String){
        if let operation = Operations[_symbol]{
            switch operation{
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                accumulator = function(accumulator!)
            case .binaryOperation(let function):
                if accumulator != nil{
                    binaryOperation = BinaryOperation(function: function,Operand1: accumulator!)
                    accumulator = nil
                }
            case .equals:
                remainingOperation()
            break
            }
        }
    }
   
    
    mutating func remainingOperation(){
        if binaryOperation != nil && accumulator != nil{
            accumulator = binaryOperation!.perform(with: accumulator!)
            binaryOperation = nil
        }
    }
    mutating func setOperand(_operand:Double){
        accumulator = _operand
    }
    var result: Double?{
        get{
            return accumulator
            
        }
    }
    
}

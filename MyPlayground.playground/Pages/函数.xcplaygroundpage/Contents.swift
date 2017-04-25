//: [Previous](@previous)

import Foundation
// 函数
//func greet(person: String) -> String {
//    let greeting = "Hello," + person + "!"
//    return greeting
//}
//greet(person: "雷雷")
//
//func greetAgain(person: String) -> String {
//    return "Hello again," + person + "!"
//}
//print(greetAgain(person: "布雷克"))
//print(greetAgain(person: "雷阿伦"))
//
////无餐数函数
//func sayHelloWorld() -> String {
//    return "hello, world"
//}
//print(sayHelloWorld())
//
////多参数函数
//func greet(prerson: String, alreadyGreeted:Bool) -> String {
//    if alreadyGreeted {
//        return greetAgain(person: prerson)
//    }else {
//        return greet(person: prerson)
//    }
//}
//print(greet(prerson: "诺维斯基", alreadyGreeted: true))
//
////无返回值函数
//func greet(person: String) {
//    print("Hello, \(person)!")
//}
//
//greet(person: "小乔丹")
//
//func printAndCount(string: String) -> Int {
//    return string.characters.count
//}
//
//func printWithoutCounting(string: String) {
//    let _ = printAndCount(string: string)
//}
//
//printAndCount(string: "hello, world")
//printWithoutCounting(string: "hello, world")
//
////多重返回值函数
////
////func minMax(array: [Int]) -> (min: Int, max: Int) {
////    var currentMin = array[0]
////    var currentMax = array[0]
////    for value in array[1..<array.count] {
////        if value < currentMin {
////            currentMin = value
////        }else if value > currentMax {
////            currentMax = value
////        }
////    }
////    return (currentMin, currentMax)
////}
////
////print(minMax(array: [5,3,44,2,6,77,432,5,44]))
//
////可选元组返回类型
//
//func minMax(array: [Int]) -> (min: Int, max: Int)? {
//    if array.isEmpty {
//        return nil
//    }
//    var currentMin = array[0]
//    var currentMax = array[0]
//    for value in array[1..<array.count] {
//        if value < currentMin {
//            currentMin = value
//        }else if value > currentMax {
//            currentMax = value
//        }
//    }
//    return (currentMin, currentMax)
//}
//
//if let bounds = minMax(array: [8,-6,2,109,3,71]) {
//    print("min is \(bounds.min) and max is \(bounds.max)")
//}

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

var tempa = 1
var tempb = 2
swapTwoInts(&tempa, &tempb)

print(tempa, tempb)

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

func printHelloWorld() {
    print("hello world")
}

var mathFunction: (Int, Int) -> Int = addTwoInts
var multiplyMathFunction: (Int, Int) -> Int = multiplyTwoInts


print(mathFunction(1, 1))
print(multiplyMathFunction(1, 2))

//函数类型作为参数类型
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 10, 20)

func stepForward(_ input: Int) -> Int {
    return input + 1
}

func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

chooseStepFunction(backward: true)(2)

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)


func moveNearerToZeroFunction( currentValue: inout NSInteger) {
    print("counting to zero: \(currentValue)")
    while currentValue != 0 {
        print(currentValue)
        currentValue = moveNearerToZero(currentValue)
    }
}
currentValue = 100

moveNearerToZeroFunction(currentValue: &currentValue)

print(currentValue)

//嵌套函数
func chooseStepFunction1(backward: Bool) -> (Int) -> Int {
    func stepForward1(input: Int) -> Int { return input + 1 }
    func stepBackward1(input: Int) -> Int { return input - 1 }
    return backward ? stepForward1 : stepBackward1
}












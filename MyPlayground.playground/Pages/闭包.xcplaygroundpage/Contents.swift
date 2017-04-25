
import Foundation

////闭包
//
//let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
//
//func backward(s1: String, s2: String) -> Bool {
//    return s1 > s2
//}
//var reversedNames = names.sorted(by: backward)
//print(reversedNames)
//
////闭包表达式
//
///*
// {
//    (parameters) -> returnType in
//        statements
// }
// */
//
//var reversedNamess = names.sorted {(s1: String, s2: String) -> Bool in
//    return s1 > s2
//}
//
//var reversedName1s = names.sorted() { $0 > $1 }
//
//
//var reversedNamesss = names.sorted(by: { s1, s2 in
//    s1 > s2 })
//
//var reversedNamessss = names.sorted(by: { $0 > $1} )
//
////运算符方法
//var reversedNamesssss = names.sorted(by: >)
//
////尾随闭包
//func someFunctionThatTakesAClosure(closure: () -> Void) {
//    print(closure)
//}
//
//someFunctionThatTakesAClosure(closure: { })
//
//someFunctionThatTakesAClosure {
//    
//}
//
////尾随闭包 map
//let digitNames = [0: "zero", 1: "one", 2: "two", 3: "three", 4: "four", 5: "five", 6: "six", 7: "seven", 8: "eight", 9: "nine"]
//let numbers = [1634564, 58, 510]
//
//let strings = numbers.map { (number) -> String in
//    var number = number
//    print(number)
//    var output = ""
//    repeat {
//        output = digitNames[number % 10]! + output
//        number /= 10
//    } while number > 0
//    return output
//}
//
//print(strings)
//
////值捕获
//func makeIncrementer(forIncrement amount: Int) -> () -> Int {
//    var runningTotal = 0
//    func incrementer() -> Int {
//        runningTotal += amount
//        return runningTotal
//    }
//    return incrementer
//}
//
//var incrementer = makeIncrementer(forIncrement: 10)
//print(incrementer())
//print(incrementer())
//
//let incrementBySeven = makeIncrementer(forIncrement: 7)
//print(incrementBySeven())
//print(incrementBySeven())
//
////闭包是引用类型
//let incrementBysevens = incrementBySeven
//print(incrementBysevens())

//逃逸闭包
/*
 当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。
 */
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
    print(completionHandlers.count)
}

someFunctionWithEscapingClosure(completionHandler: { })

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 50 }
        
        someFunctionWithNonescapingClosure { x = 40 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
var closure = completionHandlers.last!
closure()
print(instance.x)

//自动闭包

var customersInLine = [1, 2, 3, 4, 5]
print(customersInLine.count)

let customerProvider = { customersInLine.remove(at: 0) }

print(customerProvider)

func serve(customer customerProvider: () -> Int) {
    print("Now serving \(customerProvider())")
}

print(serve(customer: customerProvider))





















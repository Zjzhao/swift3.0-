
import Foundation

//扩展
/*
 1，扩展语法
 2，计算型属性
 3，构造器
 4，方法
 5，下标
 6，嵌套类型
 */
/*
 1，添加计算型属性和计算型类型属性
 2，定义实例方法和类型方法
 3，提供新的构造器
 4，定义下标
 5，定义和使用新的嵌套类型
 6，使一个已有类型符合某个协议
 */

//计算型属性
extension Double {
    var km: Double {
        return self * 1_000.0
    }
    
    var m: Double {
        return self
    }
    
    var cm: Double {
        return self / 100.0
    }
    
    var mm: Double {
        return self / 1_000.0
    }
    
    var ft: Double {
        return self / 3.28084
    }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

let fiveThousand = 5.km
print("five thousand is \(fiveThousand) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")

//构造器

struct Size {
    var width = 0.0
    var height = 0.0
}

struct Point {
    var x = 0.0
    var y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

//方法

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

10.repetitions {
    print("Hello!")
}

//可变实例方法
extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()
print("\(someInt)")

//下标
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

print("\(12345[6])")

//嵌套类型

extension Int {
    
    enum Kind {
        case Negative, Zero, Positive
    }
    
    var Kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.Kind {
        case .Negative:
            print("---\(number)---")
        case .Zero:
            print("---\(number)---")
        case .Positive:
            print("---\(number)---")
        }
    }
    print("")
}

printIntegerKinds([3,19,-27,0,-6,0,7])

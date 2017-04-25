//: Playground - noun: a place where people can play

import UIKit

let objects = [1,2,3,4,5,6,7,8,9]
for var obj in objects {
    print(obj)
}

var i = 0
while i < objects.count  {
    print(objects[i])
    i+=1
}


repeat {
    print(i)
} while (i < objects.count)

let label = "red label"
switch label {
case "redlabel":
    print("redlabel")
case let x where x.hasPrefix("red"):
        print("hasPriefix red label")
default:
    print("default")
}

let numbers = [
    "oneRow" : [1,2,3,4,5,6,7,8,9],
    "twoRow" : [11,12,13,14,15,16,17],
    "threeRow" : [21,22,23,24,25,26,27,28],
]
var largest:NSInteger = 0
var orders = [NSInteger]()
for (kind, objects) in numbers {
    print(kind)
    for y in objects {
        if y > largest {
            largest = y
            print(largest)
        }
    }
    orders.append(largest)
}

for i in 0...4 {
    print(i)
    print("123")
}

func calculateStatistics(scores: [NSInteger]) -> (min: NSInteger,max: NSInteger, sum: NSInteger) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        }else if score < min {
            min = score
        }
        sum += score
    }
    return (min,max,sum)
}

let statistics = calculateStatistics(scores: [1,100,0,2,2,33,12,4,555,2,1])
print(statistics)
print(statistics.min)
print(statistics.max)
print(statistics.sum)

func sumOf(numbers: NSInteger...) -> NSInteger {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}

sumOf(numbers: 1,2)

//平均数
func averageOf(numbers: NSInteger...) -> NSInteger {
    var number:NSInteger = 0
    var sum:NSInteger = 0
    
    for num in numbers {
        number += 1
        sum += num
    }
    return sum/number
}

averageOf(numbers: 1,2,3,4,5,6,7)

//函数嵌套
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()

func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1+number
    }
    return addOne
}

var function = makeIncrementer()
function(10)

func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            print(item)
        }else {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}

hasAnyMatches(list: [1,2,3,4,5,6,7,8,9,10], condition: lessThanTen)

//闭包
var arrays: [Int] = [5,2,4,6,9]
arrays.map { (number: Int) -> Int in
    let result = 3 * number
    return result
}

var newArrays = arrays.map { (number: Int) -> Int in
    print(number%2)
    if (number%2 != 0) {
        return 0
    }else {
        return number
    }
}
print(newArrays)

var new1Arrays = arrays.map { number in 3 * number }
print(new1Arrays)

let sortedNumbers = arrays.sorted { (num1, num2) -> Bool in
    num1 < num2
}
print(sortedNumbers)

//class

class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name:String) {
        self.name = name
    }
    
    open func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides"
    }
    
}

class Square: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 10
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)"
    }
}

let test = Square(sideLength: 10.0, name: "xiao hong")
test.area()
test.simpleDescription()

class Circle: NamedShape {
    var radius: Double = 0.0
    
    init(radius: Double, name:String) {
        self.radius = radius
        super.init(name: name)
    }
    
    func area() -> Double {
        return radius * radius
    }
    
    override func simpleDescription() -> String {
        return "a circle"
    }
    
    var perimeter: Double {
        get {
            return radius * 3.0
        }
        set (abc) {
            radius = abc / 3.0
        }
    }
    
    var perimeter1: Double? {
        willSet {
            radius = 10.0
        }
    }
}

var circle = Circle(radius: 20.0, name: "xiao niu")
circle.perimeter = 100.0
print(circle.perimeter)

circle.perimeter1 = 200.0
print(circle.perimeter1!)

print(circle.radius)

//使用枚举

enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

var rank = Rank.Ace
rank.simpleDescription()

let ace = Rank.Ace
let aceRawValue = ace.rawValue

enum Suit {
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
    func color() -> String {
        switch self {
        case .spades, .clubs:
            return "black"
        case .hearts, .diamonds:
            return "red"
        }
    }
}

let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()

let heartsColor = hearts.color()

enum ServerResponse {
    case Result(String, String)
    case Failure(String)
}

let success = ServerResponse.Result("6:00 am", "8:00 pm")
let failure = ServerResponse.Failure("error")

switch failure {
case let .Result(sunrise, sunset):
    let serverResponse = "sunrise is at \(sunrise) and sunset is at \(sunset)"
case let .Failure(message):
    let failure = "failure: \(message)"
    print(failure)
}

struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}









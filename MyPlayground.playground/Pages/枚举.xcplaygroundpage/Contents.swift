
import Foundation

//enum
enum CompassPoint: NSInteger {
    case north
    case south
    case east
    case west
}

enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionToHead = CompassPoint.west
directionToHead = .north
directionToHead = .south
directionToHead = .east
print(directionToHead.hashValue)

directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

switch directionToHead {
case .north:
    print("Lots of planets have a north")
default:
    print("Not a safe place for humans")
}

//关联值
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(1, 2, 3, 4)

//productBarcode = .qrCode("123456789")

switch productBarcode {
case let .upc(number1, number2, number3, number4):
    print("UPC: \(number1), \(number2), \(number3), \(number4)")
case let .qrCode(numberString):
    print("QR code: \(numberString)")
}

//原始值

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

//原始值的隐式赋值
enum Planet1: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

print(Planet1.mercury.rawValue)
print(Planet1.mercury.hashValue)

let possiblePlanet = Planet1(rawValue: 1)

let positionToFind = 11
if let somePlanet = Planet1(rawValue: positionToFind) {
    switch somePlanet {
    case .mercury:
        print(" mercury ")
    default:
        print("Not a safe place for humans")
    }
}else {
    print("There isn't a planet at position \(positionToFind)")
}

//递归枚举
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))


func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))


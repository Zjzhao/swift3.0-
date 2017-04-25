//: [Previous](@previous)

import Foundation

let oddDigits: Set = [1,2,3,4,5]
let evenDigits: Set = [4,5,6,7,8]
let singleDigitPrimeNumbers: Set = [7,8,9]

//方法根据两个集合的值创建一个新的集合
var tempSet = oddDigits.union(evenDigits)
print(tempSet)
//方法根据不在该集合中的值创建一个新的集合
tempSet = []
tempSet = oddDigits.subtracting(evenDigits)
print(tempSet)
//方法根据在一个集合中但不在两个集合中的值创建一个新的集合
tempSet = []
tempSet = oddDigits.symmetricDifference(evenDigits)
print(tempSet)
//方法根据两个集合中都包含的值创建的一个新的集合
tempSet = []
tempSet = oddDigits.intersection(evenDigits)
print(tempSet)

let houseAnimals: Set = ["?", "?"]
let farmanimals: Set = ["?", "?", "?", "?", "?", "?"]
let cityAnimals: Set = ["?", "?"]

houseAnimals.isSubset(of: farmanimals)
farmanimals.isSuperset(of: houseAnimals)
farmanimals.isDisjoint(with: cityAnimals)

//dictionary

var namesOfIntegers: [Int: String]? = [:]
namesOfIntegers?[1] = "100"

func namesOfInteger() {
    guard let temp = namesOfIntegers else {
        print("失败了")
        return
    }
    print(temp)
}

namesOfInteger()

namesOfIntegers?.updateValue("123", forKey: 2)
namesOfIntegers?.updateValue("456", forKey: 3)
namesOfIntegers?.updateValue("789", forKey: 4)
namesOfIntegers?.updateValue("000", forKey: 5)

print(namesOfIntegers as Any)

for (order, name) in namesOfIntegers! {
    print(order)
    print(name)
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (name, count) in numberOfLegs {
    print(name)
    print(count)
    print((name, count))
}

let finalSquare = 25
var board = Array<Int>(repeating: 1, count: finalSquare+1)

//switch
func anotherCharacte(character: Character) {
    let anotherCharacter: Character = character
    switch anotherCharacter {
    case "a":
        print("this is a")
    case "b":
        print("this is b")
    case "c":
        print("this is c")
    case "d":
        print("this is d")
    default:
        print("not is a or b or c or d")
    }
}

var anotherCharacter:Character = "a"

anotherCharacte(character: anotherCharacter)
anotherCharacter = "b"
anotherCharacte(character: anotherCharacter)
anotherCharacter = "c"
anotherCharacte(character: anotherCharacter)
anotherCharacter = "d"
anotherCharacte(character: anotherCharacter)

let approximateCount = 62
let countedThings = "noons orbiting saturn"
var naturalCount: String
switch approximateCount {
    case 0:
    naturalCount = "no"
    case 1..<5:
    naturalCount = "a few"
    case 5..<12:
    naturalCount = "several"
    case 12..<100:
    naturalCount = "dozens of"
    case 100..<1000:
    naturalCount = "hundreds of"
    default:
        naturalCount = "many"
}

func somePointFunction(sompPoint:(x: Int, y: Int)) {
    let somePoint = sompPoint
    switch somePoint {
    case (0, 0):
        print("(0, 0) is at the origin")
    case (_, 0):
        print("(\(somePoint.0), 0) is on the x-axis")
    case (0, _):
        print("(0, \(somePoint.1)) is on the y-axis")
    case (-2...2, -2...2):
        print("(\(somePoint.0), \(somePoint.1))) is inside the box")
    default:
        print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
    }
}

somePointFunction(sompPoint: (2, 2))

let anotherPoint = (1, 100)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("on the x-axis with an x value of 2")
}

func yetAnotherPointFunction(yetAnotherPoint: (x: Int, y: Int)) {
    let yetAnotherPoint = yetAnotherPoint
    switch yetAnotherPoint {
    case let (x, y) where x == y:
        print("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:
        print("(\(x), \(y)) is on the line x == -y")
    case let (x, y):
        print("(\(x), \(y)) is just some arbitrary point")
    }
}
yetAnotherPointFunction(yetAnotherPoint: (1, 2))

func someCharacterFunction(someCharacter: Character) {
    let someCharacter: Character = someCharacter
    switch someCharacter {
    case "a","e","i","o","u":
        print("\(someCharacter) is a vowel")
    case "b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z":
        print("\(someCharacter) is a consonant")
    default:
        print("\(someCharacter) is not a vowel or a consonant")
    }
}
someCharacterFunction(someCharacter: "c")

func stillAnotherPointFunction(stillAnotherPoint: (pointL:Int, pointR:Int)) {
    let stillAnotherPoint = stillAnotherPoint
    switch stillAnotherPoint {
    case (let distance, 0), (0, let distance):
        print("on an axis, \(distance) from the origin")
    default:
        print("not on an axis")
    }
}
stillAnotherPointFunction(stillAnotherPoint: (0, 0))

//控制转移语句
/*
 continue break fallthrough return throw
 */
//Continue

func removeCharacter(characters: String) -> String {
    let puzzleInput = characters
    var puzzleOutput = ""
    
    for character in puzzleInput.characters {
        switch character {
        case "a", "e", "i", "o", "u":
            puzzleOutput.append("_")
            continue
        default:
            puzzleOutput.append(character)
        }
    }
    return puzzleOutput
}

var puzzleOutput = removeCharacter(characters: "great minds think alike")
print(puzzleOutput)

//Break
let numberSymbol: Character = "3"
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "?", "一", "?":
    possibleIntegerValue = 1
case "2", "?", "二", "?":
    possibleIntegerValue = 2
case "3", "?", "三", "?":
    possibleIntegerValue = 3
case "4", "?", "四", "?":
    possibleIntegerValue = 4
default:
    break
}

if let integerValue = possibleIntegerValue {
    print("the integer value of \(numberSymbol) is \(integerValue)")
}else {
    print("An integer value could not be found for \(numberSymbol)")
}

let integerToDescribe = 1
var description = "the number \(integerToDescribe) is "
switch integerToDescribe {
case 2,3,5,7,11,13,17,19:
    description += "a prime number, and also "
    fallthrough
case 1,4,6,8:
    fallthrough
default:
    description += "an integer"
}
print(description)

iLoop: for i in 0..<100 {
    jLoop: for j in 0..<50 {
        if j > 25 {
            break iLoop
        }
        print("out:\(i) - in:\(j)")
    }
}



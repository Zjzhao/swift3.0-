
import Foundation

//协议详解
/*
 1，协议语法
 2，属性要求
 3，方法要求
 4，Mutating 方法要求
 5，构造器要求
 6，协议作为类型
 7，委托模式
 8，通过扩展添加协议一致性
 9，通过扩展遵循协议
 10，协议类型的集合
 11，协议的继承
 12，类类型专属协议
 13，协议合成
 14，检查协议一致性
 15，可选的协议要求
 16，协议扩展
 */

//协议语法
//protocol SomeProtocol {
//    //这里是协议的定义部分
//}
//
//struct SomeStructure: FirstProtocol, AnotherProtocol {
//    //这里是结构体的定义部分
//}
//
//class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
//    //这里是类的定义部分
//}

//属性要求
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")
print(john.fullName)

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        
        return (prefix != nil ? prefix! + " " : "") + name

    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
ncc1701.fullName

//方法要求

protocol SomeFunctionProtocol {
    static func someTypeMethod()
}

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
//        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m)
        lastRandom = Double(Int(lastRandom * a + c) % Int(m))
        print("\(lastRandom)")
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")

//Mutating 方法要求

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case .Off:
            self = .On
        case .On:
            self = .Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()

//构造器要求

protocol SomeClassProtocol {
    
    init(someparameter: Int)
    
}

class SomeClass: SomeClassProtocol {
    required init(someparameter: Int) {
        
    }
    
    init(paramters: String) {
        
    }
}

class subSomeClass:SomeClass {
    override init(paramters: String) {
        super.init(paramters: paramters)
        
    }
    
    required init(someparameter: Int) {
        fatalError("init(someparameter:) has not been implemented")
    }
}

protocol SomeClass1Protocol {
    init()
    init?(name: String)
}

class SomeSuperClass {
    init() {
        
    }
}

class SomeSubClass: SomeSuperClass, SomeClass1Protocol {
    required override init() {
        super.init()
    }
    
    //可失败构造器要求
    required init?(name: String) {
        _ = name
        super.init()
    }
    
}

//协议作为类型

/*
 1，作为函数，方法或构造器中的参数类型或返回值类型
 2，作为常量，变量，或属性的类型
 3，作为数组，字典或其他容器中的元素类型
 */

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}


//委托（代理）模式

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    var delegate: DiceGameDelegate?
    
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square == board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and ladders")
        }
        print("The game is using a \(game.dice.sides) - sided dice")
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted fo \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

//通过扩展添加协议一致性

protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

var d12 = Dice(sides: 1, generator: LinearCongruentialGenerator())
d12.textualDescription

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of snakes and Ladders with \(finalSquare) squares"
    }
}

//通过扩展遵循协议

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
somethingTextRepresentable.textualDescription

//协议类型的集合
let things: [TextRepresentable] = [game, d12, simonTheHamster]
for thing in things {
    print(thing.textualDescription)
}

//协议的继承

protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    //定义部分
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettytextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettytextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "正三角"
            case let snake where snake < 0:
                output += "倒三角"
            default:
                output += "园"
            }
        }
        return output
    }
}

print(game.prettytextualDescription)

//类类型专属协议

protocol SomeClassOnlyprotocol: class, SomeFunctionProtocol {
    
}

//协议合成

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct person: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday( to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

let birthdayPerson = person(name: "Malcolm", age:21)
wishHappyBirthday(to: birthdayPerson)

//检查协议一致性
/*
 is as? as!
 */
protocol hasArea {
    var area: Double { get }
}

class Circle: hasArea {
    let pi = 3.1415926
    var radius: Double
    var area: Double {
        return pi * radius * radius
    }
    init(radius: Double) {
        self.radius = radius
    }
}

class Country: hasArea {
    
    var area: Double

    init(area: Double) {
        self.area = area
    }
}

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 234_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? hasArea {
        print("Area is \(objectWithArea.area)")
    }else {
        print("something that doesn't have an area")
    }
}

//可选的协议要求
/*
 @objc
 */
@objc protocol CounterDataSource {
   @objc optional func incrementForCount(count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count: count) {
            count += amount
        }else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

@objc class ThreeSource: NSObject, CounterDataSource {
    var fixedIncrement: Int = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()

for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

@objc class TowardsZeroSource: NSObject, CounterDataSource {
    func incrementForCount(count: Int) -> Int {
        if count == 0 {
            return 0
        }else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}

//协议扩展
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generatorr = LinearCongruentialGenerator()
print("here's a random number: \(generatorr.random())")
print("And here's a random Boolean: \(generatorr.randomBool())")

//通过扩展提供默认实现

extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

//为协议扩展添加限制条件


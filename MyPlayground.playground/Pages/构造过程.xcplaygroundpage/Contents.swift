
import Foundation

//存储属性的初始化-构造器
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

var f = Fahrenheit()
print("The default temperature is \(f.temperature) Fahrenheit")


//默认值

struct Fahrenheit1 {
    var temperature = 32.0
}

//构造参数

struct Celsius {
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

print(boilingPointOfWater.temperatureInCelsius)
print(freezingPointOfWater.temperatureInCelsius)

//参数的内部名称和外部名称

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

struct Celsius1 {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

var bodyTemperature = Celsius1(37.0)
bodyTemperature = Celsius1(fromFahrenheit: 36.0)
bodyTemperature = Celsius1(fromKelvin: 35.0)
print(bodyTemperature.temperatureInCelsius)

//可选属性类型
class SurveyQuestion {
    var text: String
    var response: String?
    var response1: Int?
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes I do like cheese"
//cheeseQuestion.response1 = 123
print(cheeseQuestion.response as Any)
if let temp = cheeseQuestion.response1 {
    print("123")
}else {
    print("654321")
}

class SurveyQuestion1 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

let beetsQuestion = SurveyQuestion1(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets"

//默认构造器
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingListItem()

//结构体的逐一成员构造器
struct Size {
    var width = 0.0, height = 0.0
}

let twoByTwo = Size(width: 2.0, height: 2.0)

//值类型的构造器

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    init() {}
    
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

//类的继承和构造过程

//指定构造器和便利构造器

//两段式构造过程: 两个阶段

//构造器继承和重写

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel"
    }
}

class Bicycle: Vehicle {
    var name: NSString
    override init() {
        self.name = "xiao lan"
        super.init()
        numberOfWheels = 2
    }
    
    
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

//构造器的自动继承

class Food {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: "name", quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "#Eggs", quantity: 6)

class ShoppingListItem1: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ?" : " ?"
        return output
    }
}

let oneMysteryItem1 = ShoppingListItem()
let oneBacon1 = ShoppingListItem1(name: "Bacon")
let sixEggs1 = ShoppingListItem1(name: "name", quantity: 1)

print("\(oneMysteryItem1.purchased)")
print("\(oneMysteryItem.name)")

var breakfastList = [
    ShoppingListItem1(),
    ShoppingListItem1(name: "小李"),
    ShoppingListItem1(name: "小王", quantity: 1)
]

breakfastList[0].name = "王力宏"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

//可失败构造器

//结构体
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

let someCreature = Animal(species: "")

if let giraffe = someCreature {
    print("An animal was initialized with a speies of \(giraffe.species)")
}

//枚举
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

var unitEnum = TemperatureUnit(symbol: "K")
print("\(unitEnum)")
unitEnum = .Celsius

//带原始值的枚举类型的可失败构造器

enum TemperatureUnit1: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
    
}

let fahrenheitUnit = TemperatureUnit1(rawValue: "F")
if fahrenheitUnit != nil {
    print("")
}

let unknownUnit = TemperatureUnit1(rawValue: "X")
if unknownUnit == nil {
    print("")
}

//构造失败的传递

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        print("------1-------")
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
        print("-------2-------")
    }
}

let cartItem = CartItem(name: "", quantity: 1)
if cartItem == nil {
    print("\(cartItem)")
}

//重写一个可失败构造器

class Doucument {
    var name: String?
    init() {
        
    }
    
    init?(name: String) {
        self.name = name
        if name.isEmpty {
            return nil
        }
    }
}

class AutomaticallyNamedDocument: Doucument {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[untitled]"
        }else {
            self.name = name
        }
    }
}

class UntitledDocument: Doucument {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

//必要构造器
class SomeClass {
    required init() {
        
    }
}

class someSubclass: SomeClass {
    required init() {
        
    }
}

//通过闭包或函数设置属性的默认值

class SomeClass1 {
    let someProperty: String = {
        return "123"
    }()
}

struct Checkerboard {
    var boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
    
    func condition(row: Int, column: Int) -> Bool {
        if row > 7 || row < 0 || column > 8 || column < 0 {
            return false
        }
        return true
    }
    
    subscript(row: Int, column: Int, temp tem: Int) -> Bool {
        get {
            assert(condition(row: row, column: column), "Index out of range")
            return boardColors[(row * 8) + column]
        }
        set {
            assert(condition(row: row, column: column), "Index out of range")
            boardColors[(row * 8) + column] = newValue
        }
    }
}

var board = Checkerboard()
let booll = board.squareIsBlackAtRow(row: 1, column: 1)
print(board.boardColors)












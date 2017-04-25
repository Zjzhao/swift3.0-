
import Foundation

class SomeClass {
    //在这里定义类
}

struct SomeStructure {
    //在这里定义结构体
}

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()

print("the width of someResolution is \(someResolution.width)")
print("the width of someVideoMode is \(someVideoMode.resolution.width)")

someVideoMode.resolution.width = 1024
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")

//结构体类型的成员逐一构造器
let vga = Resolution(width: 640, height: 480)
print("\(vga)")

//结构体和枚举是值类型
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")

print("hd is still \(hd.width) pixels wide")

//枚举也遵循相同的行为准则
enum CompassPoint {
    case North, South, East, West
}

var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West")
}

//类是引用类型
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

tenEighty.resolution.width = 123
print("width - \(tenEighty.resolution.width)")
print("width - \(hd.width)")

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
print("The frameRate property of alsoTenEighty is now \(alsoTenEighty.frameRate)")

//恒等运算
/*
 等价于 （===）
 不等价于 （!==）
 */

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to teh same Resolution instance")
}

//属性

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6
print(rangeOfThreeItems)

//常量结构体的存储属性

var rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
rangeOfThreeItems.firstValue = 10
print(rangeOfThreeItems.firstValue)

//延迟存储属性

class DataImporter {
    /*
     DataImporter 是一个负责将外部文件中的数据导入的类，这个类的初始化会消耗不少时间。
     */
    var fileName = "data.txt"
    //这里会提供数据导入功能
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    //这里会提供数据管理功能
}

let manager  = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

let temp = manager.importer

print(temp.fileName)

//计算属性

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width/2)
            let centerY = origin.y + (size.height/2)
            return Point(x: centerX, y: centerY)
        }
        
        set(newCenter) {
            origin.x = newCenter.x - (size.width/2)
            origin.y = newCenter.y - (size.height/2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

//只读计算属性
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 6.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

//属性观察器
class StepCounter {
    var totalSteps: Int = 0 {
        willSet (newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps -  oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
print("\(stepCounter.totalSteps)")
stepCounter.totalSteps = 200
print("\(stepCounter.totalSteps)")
stepCounter.totalSteps = 360
print("\(stepCounter.totalSteps)")
stepCounter.totalSteps = 100

func testInout(a: inout Int) {
    print("------- a -------")
}

testInout(a: &stepCounter.totalSteps)

//类型属性

struct SomeStructuree {
    var a: Int = 1
//
//    static var storedTypeProperty = "0"
//    static var computedTypeProperty: String {
//        get {
//            return "1"
//        }
//        set(newProperty) {
//            storedTypeProperty = newProperty
//        }
//    }
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int { //只读
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClasss {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 27
    }
    
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

class TempClasss: SomeClasss {
    
    override class var overrideableComputedTypeProperty: Int {
        return 100
    }
    
}

print(TempClasss.overrideableComputedTypeProperty)



struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(rightChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

rightChannel.currentLevel = 11
debugPrint(AudioChannel.maxInputLevelForAllChannels)












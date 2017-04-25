
import Foundation

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
}

let counter = Counter()

counter.increment()
print(counter.count)
counter.increment(by: 5)
print(counter.count)
counter.reset()
print(counter.count)

//self

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}

let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}

struct Pintt {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var somePoint1 = Pintt(x: 1.0, y: 1.0)
somePoint1.moveByX(deltaX: 2.0, deltaY: 3.0)
print(somePoint1.x, somePoint1.y)
somePoint1.x = 1.0
somePoint1.y = 1.0
print(somePoint1.x, somePoint1.y)

struct Pointtt {
    var x = 0.0, y = 0.0
    mutating func moveBy(deltaX: Double, deltaY: Double) {
        self = Pointtt(x: x + deltaX, y: y + deltaY)
    }
}

var somePoint2 = Pointtt(x: 1.0, y: 1.0)
somePoint2.moveBy(deltaX: 2.0, deltaY: 3.0)
print(somePoint2.x, somePoint2.y)
somePoint2.moveBy(deltaX: 1.0, deltaY: 1.0)
print(somePoint2.x, somePoint2.y)

enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}

var ovenLight = TriStateSwitch.Low
ovenLight.next()
print(ovenLight)
ovenLight.next()
print(ovenLight)
ovenLight.next()
print(ovenLight)

//类型方法

class SomeClass {
    var temp: Int = 0
    
    class func someTypeMethod() -> (SomeClass) {
        //这里实现类方法
        let some = SomeClass()
        some.temp = 10
        
        return some
    }
}


struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        }else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    var playerName: String?
    func complet(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complet(level: 1)
player.complet(level: 1)
player.complet(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
}else {
    print("level 6 has not yet been unlocked")
}

//下标

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 3, columns: 3)
matrix[0,1] = 1
matrix[1,0] = 2
matrix[2,0] = 3
print(matrix)




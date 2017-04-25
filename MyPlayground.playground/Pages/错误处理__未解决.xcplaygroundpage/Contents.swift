
import Foundation

//错误处理

/*
 1，表示并抛出错误
 2，处理错误
 3，制定清理操作
 */

//表示并抛出错误

enum VendingMachineError: Error {
    case invalidSelection // 选择无效
    case insufficientFunds(coinsNeeded: Int) //金额不足
    case outOfStock //缺货
}

throw VendingMachineError.insufficientFunds(coinsNeeded: 5)

var temp = VendingMachineError.insufficientFunds(coinsNeeded: 5)
switch temp {
case .invalidSelection:
    print("-------")
case let .insufficientFunds(coinsNeeded):
    print("\(coinsNeeded)")
default:
    print("-------")
}

//处理错误
/*
 swift有4种错误处理的方式， 1,do - catch 2,断言 3,try try? try! 4,throw
 */

//用 throwing 函数传递错误

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = ["Candy Bar": Item(price: 12, count: 7),
                     "Chips": Item(price: 10, count: 4),
                     "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    
    func vend(itemnamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels"
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    print("------\(favoriteSnacks[person])-------")
    let snackname = favoriteSnacks[person] ?? "Candy Bar"
    print("snackName: \(snackname)")
    try vendingMachine.vend(itemnamed: snackname)
}

do {
    try buyFavoriteSnack(person: "123", vendingMachine: VendingMachine())
} catch VendingMachineError.invalidSelection {
    print("invalidSelection")
} catch VendingMachineError.insufficientFunds(5) {
    print("VendingMachineError ---- 5")
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemnamed: name)
        self.name = name
    }
}


//-----------------

//附自定义Dog类和调用Dog类的代码
enum DogError : Error{
    case NameInvalidError
    case AgeInvalidError
    case NameLengthError
}

class Dog: NSObject {
    var name : String!
    var age : Int!
    init(name:String,age:Int){
        self.name = name
        self.age = age
    }
    
    func printDogMessage(dog: Dog) throws -> String{
        print("Dog-Class:开始检查名字是否无效")
        guard let name : String = dog.name else{
            throw DogError.NameInvalidError
        }
        print("Dog-Class:开始检查名字长度是否无效")
        if name.characters.count < 3{
            throw DogError.NameLengthError
        }
        print("Dog-Class:开始检查年龄是否无效")
        if age < 0 || age > 20{
            throw DogError.AgeInvalidError
        }
        print("Dog-Class:返回信息")
        return "dog的信息为" + dog.name + "\(dog.age)"
    }
}

//测试方法的代码:

let myDog = Dog(name: "小白", age: 21)
var str : String!
do{
    try str = myDog.printDogMessage(dog: myDog)
}
catch {
    switch (error){
    case DogError.NameInvalidError: print("dog的名字无效错误")
    case DogError.NameLengthError : print("dog的名字长度错误")
    case DogError.AgeInvalidError : print("dog的年龄设置不合法")
    default:print("Main:捕获到dog其他错误")
    }
}
print("Main:最后输出为\(str)")

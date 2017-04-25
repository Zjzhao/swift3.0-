
import Foundation

//可选链式调用
/*
 1，使用可选链式调用代替强制展开
 2，为可选链式调用定义模型
 3，通过可选链式调用调用方法
 4，通过可选链式调用访问下标
 5，连接多层可选链式调用
 6，在方法的可选返回值上进行可选链式调用
 */

//使用可选链式调用代替强制展开

class Person {
    var residence: Residence?
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        }else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        }else {
            return nil
        }
    }
}

let john = Person()
//let roomCount = john.residence!.numberOfRooms //错误

//可选链式调用
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s)")
}else {
    print("Unable to retrieve the number of rooms")
}

let roomCount = john.residence?.numberOfRooms
if roomCount == nil {
    print("is nill")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress

func createAddress() -> Address {
    print("Function was called")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}

john.residence?.address = createAddress()
if john.residence?.printNumberOfRooms() == nil {
    print("\(john.residence?.printNumberOfRooms())")
}

//通过可选链式调用访问下标
if let temp = john.residence?[0].name {
    print("the first room name is")
}else {
    print("unable to retrieve the first room name")
}

john.residence?[0] = Room(name: "Bathroom")

john.residence = Residence()
john.residence?.address = Address()
john.residence?.address?.buildingName = "123456"
if let temp = john.residence?.address?.buildingName {
    print(temp)
}

if john.residence?.rooms.count != 0 {
    if let temp = john.residence?[0].name {
    print("the first room name is")
    }else {
    print("unable to retrieve the first room name")
    }
}

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("the first room name is \(firstRoomName)")
}else {
    print("Unable to retrieve the first room name")
}

//访问可选类型的下标

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91  //成功
testScores["Bev"]?[0] += 1   //成功
testScores["Brian"]?[0] = 72 //失败

//连接多层可选链式调用

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet)")
}else {
    print("Unable to retrieve the address")
}

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
johnsAddress.buildingNumber = "11"
john.residence?.address = johnsAddress

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet)")
}else {
    print("Unable to retrieve the address")
}

//在方法的可选返回值上进行可选链式调用

if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier)")
}

if let beginsWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    }
}















  

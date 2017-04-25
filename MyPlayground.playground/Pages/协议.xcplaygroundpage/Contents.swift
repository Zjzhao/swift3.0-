
import Foundation

//协议

protocol ExampleProtocol {
    var simpleDescription: String { get }
    func adjust() -> Void
}

class SimpleClass: ExampleProtocol {
    
    var simpleDescription: String = "a very simple class"
    
    func adjust() {
        simpleDescription += "now 100% adusted"
    }
    
    func testA() {
        print("123")
    }
}

var a = SimpleClass()
a.adjust()
var aDescription = a.simpleDescription
print(aDescription)

//枚举
enum SimpleEnum {

    case A,B,C,D,E
    
    var simpleDescription: String {
        return "a b c d"
    }
    
    func adjust() {
        
    }

}

//extension

extension Int: ExampleProtocol {
    internal func adjust() {
        
    }

    internal var simpleDescription: String {
        return "123"
    }
}

let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)

//错误处理

enum PrinterError: Error {
    case OutOfPaper
    case NoToner
    case Onfire
}

func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.NoToner
    }
    return "Job sent"
}

//范型
func repeatItem<Item>(repeating item:Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}

repeatItem(repeating: "abcd", numberOfTimes: 10)


func orderItem<Item>(orders:Item...) -> [Item] {
    var items:[Item] = []
    for tempItem in orders {
        if tempItem as! NSInteger > 5 {
            items.append(tempItem)
        }
    }
    return items
}

orderItem(orders:1,2,3,4,5,6,7,8,9,10)

var yz:(Int, String) = (404, "登陆信息错误")

let arr1 = Array(repeating: "你好", count: 6)
let arr2 = Array(repeating: "小明", count: 7)
var array = arr1 + arr2
print(array)
array += ["d", "222"]
print(array)

array[1...2] = ["1", "2"]
print(array)

array.insert("0", at: 1)
print(array)

array.remove(at: 1)
print(array)




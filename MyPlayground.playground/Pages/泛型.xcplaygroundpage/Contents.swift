
import Foundation

//泛型

/*
 泛型所解决的问题 (页 0) 
 • 泛型函数 (页 0)
 • 类型参数 (页 0)
 • 命名类型参数 (页 0)
 • 泛型类型 (页 0)
 • 扩展一个泛型类型 (页 0) 
 • 类型约束 (页 0)
 • 关联类型 (页 0)
 • 泛型 Where 语句 (页 0)
 */

struct Stack<Element> {
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    func descriptionStack() {
        print("\(items)")
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push(item: "uno")
stackOfStrings.push(item: "dos")
stackOfStrings.push(item: "tres")
stackOfStrings.push(item: "cuatro")
stackOfStrings.descriptionStack()

stackOfStrings.pop()
stackOfStrings.descriptionStack()

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem)")
}

//类型约束

//func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    //这里是泛型函数的函数体部分
//}

//类型约束实践

func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

findIndex(ofString: "1", in: ["2","3","4","5","14","2","3"])

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3,14159, 0.1, 0.25])
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])

//关联类型

protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStack: Container {

    //IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    //container 协议的实现部分
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item: item)
    }
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct Stack1<Element>: Container {
    // Stack<Element> 的原始实现部分 
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // Container 协议的实现部分
    mutating func append(item: Element) {
        self.push(item: item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

//通过扩展一个存在的类型来指定关联类型

extension Array: Container {}

//泛型 where 语句

func allItemsMatch<C1: Container, C2:Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        return true
}

var stackOfStrings1 = Stack1<String>()
stackOfStrings1.push(item: "uno")
stackOfStrings1.push(item: "dos")
stackOfStrings1.push(item: "tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings1, arrayOfStrings) {
    print("All items match")
}else {
    print("not all items match")
}



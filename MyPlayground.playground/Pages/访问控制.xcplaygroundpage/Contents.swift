
import Foundation

//访问控制
/*
 • 模块和源文件 (页 0)
 • 访问级别 (页 0)
 • 访问控制语法 (页 0)
 • 自定义类型 (页 0)
 • 子类 (页 0)
 • 常量、变量、属性、下标 (页 0)
 • 构造器 (页 0)
 • 协议 (页 0)
 • 扩展 (页 0)
 • 泛型 (页 0)
 • 类型别名 (页 0)

 */

internal enum CompassPoint {
    case North
    case South
    case East
    case West
}

//子类

public class A {
    fileprivate func SomeMethod() {
    
    }
}

class B: A {
    override internal func SomeMethod() {
        super.SomeMethod()
    }
}

//常量，变量，属性，下标

public struct TrackedString {
    private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked"
stringToEdit.value += "This edit will increment numberOfEdits"
stringToEdit.value += "So will this one"
print("The number of edits is \(stringToEdit.numberOfEdits)")

//构造器

//协议

/*
 好乱 凌乱了。。。。。。 回头再看这个 
 */

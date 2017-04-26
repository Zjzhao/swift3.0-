
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

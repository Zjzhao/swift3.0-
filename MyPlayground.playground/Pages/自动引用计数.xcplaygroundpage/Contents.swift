
import Foundation

//自动引用计数的工作机制

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initailized")
    }
    
    deinit {
        print("\(name) is being deinitailized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleseed")
reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
reference3 = nil

//类实例之间的循环强引用

class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    weak var tenant: Person1?
    
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

class Person1: Person {
    var apartment: Apartment?
}

var john: Person1?
var unit4A: Apartment?

john = Person1(name: "John APPleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john

john = nil
unit4A = nil

//解决实例之间的循环引用 弱引用， 无主引用

//weak : 用来修饰短生命周期的类引用
//unowned : 用来修饰生命周期长的类的引用

//无主引用
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being  deinitailized")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

var john1: Customer?
john1 = Customer(name: "John Appleseed")
john1!.card = CreditCard(number: 1234_5678_9012_3456, customer: john1!)
john1 = nil

//无主引用以及隐式解析可选属性

class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: "", country: self)
        print("---------1\(capitalCity)")
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

//var country = Country(name: "Canada", capitalName: "Ottawa")
//print("\(country.name) capital city is called \(country.capitalCity.name)")

//闭包引起的循环强引用

class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: (Void) -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitailized123")
    }
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    print("----------------------------")
    return "<\(heading.name)>\(heading.text ?? defaultText) </\(heading.name)>"
}
print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "p")
print(paragraph!.asHTML())
paragraph = nil
print("--------------------------------")




		

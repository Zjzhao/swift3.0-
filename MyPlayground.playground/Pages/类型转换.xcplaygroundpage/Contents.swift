
import Foundation
//类型转换
/*
    1,定义一个类层次作为例子
    2,检查类型
    3,向下转换
    4,any 和 anyObject 的类型转换
 
 is  or  as
 */

class mediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: mediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: mediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [Movie(name: "Casablanca", director: "Michael Curtiz"),
               Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
               Movie(name: "Citizen Kane", director: "Orson Welles"),
               Song(name: "The one And Only", artist: "Chesney Hawkes"),
               Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

//检查类型

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    }else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")
print("--------------------------")

//向下转换
for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir: \(movie.director)")
    }else if let song = item as? Song {
        print("song: \(song.name), by: \(song.artist)")
    }
}

// Any 和 AnyObject 的类型转换

var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({(name: String) -> String in "hello, \(name)"})

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that i don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConerter as (String) -> String:
        print(stringConerter("Michael"))
    default:
        print("someThing else")
    }
}

let optionalNumber: Int? = 3
//things.append(optionalNumber)
things.append(optionalNumber as Any)

print("----------------------")

//嵌套类型

struct BlackjackCard {
    //嵌套的suit枚举
    enum Suit: Character {
        case Spades = "1"
        case Hearts = "2"
        case Diamonds = "3"
        case Clubs = "4"
    }
    
    enum Rank: Int {
        case Two = 2, Three, Four, five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct Values {
            let first: Int, Second: Int?
        }
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, Second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, Second: nil)
            default:
                return Values(first: self.rawValue, Second: nil)
            }
        }
    }
    let rank1: Rank, suit1: Suit
    var description: String {
        var output = "suit is \(suit1.rawValue)"
        output += "value is \(rank1.values.first)"
        if let second = rank1.values.Second {
            output += "or \(second)"
        }
        return output
    }
}

let blackjackCard = BlackjackCard(rank1: .Jack, suit1: .Spades)
print(blackjackCard.description)

//引用嵌套类型

let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue



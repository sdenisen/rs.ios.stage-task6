import Foundation

protocol CardBaseCompatible: Hashable, Codable {
    var suit: Suit {get}
    var value: Value {get}
    var isTrump: Bool {get}

    func hash(into hasher: inout Hasher)
}

enum Suit: Int, CaseIterable, Codable {
    case clubs
    case spades
    case hearts
    case diamonds
}

enum Value: Int, Codable, CaseIterable {
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    case ace
}

struct Card: CardBaseCompatible {
    let suit: Suit
    let value: Value
    var isTrump: Bool = false

    func hash(into hasher: inout Hasher) {

    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        var isEqual = false
        if lhs.isTrump == rhs.isTrump {
            if lhs.suit == rhs.suit {
                if lhs.value == rhs.value {
                    isEqual = true
                }
            }
        }
        return isEqual
    }
}

extension Card {

    func checkIfCanBeat(card: Card) -> Bool {
        if card.suit == suit {
            if card.value.rawValue < value.rawValue {
                return true
            }
        } else if isTrump == true && card.isTrump == false {
            return true
        }

        return false
    }

    func checkValue(card: Card) -> Bool {
        if card.value.rawValue == value.rawValue {
            return true
        }
        return false
    }
}

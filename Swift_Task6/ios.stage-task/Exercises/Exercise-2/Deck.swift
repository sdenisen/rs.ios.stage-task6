import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties
    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        cards = createDeck(suits: Suit.allCases, values: Value.allCases)
    }

    public func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        var cardsArr = [Card]()
        
        for suit in suits {
            for value in values {
                cardsArr.append(Card(suit: suit, value: value))
            }
        }

        return cardsArr
    }

    public mutating func shuffle() {
        cards.shuffle()
    }

    public mutating func defineTrump() {
        var trumpResult: Suit
        if cards.isEmpty {
            trump = nil
        } else {
            trumpResult = (cards[cards.count - 1]).suit
            trump = trumpResult
            setTrumpCards(for: trumpResult)
        }
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        var index = players.count * 6 > cards.count ? (cards.count - 1) : (players.count * 6 - 1)
        while index >= 0 {
            for player in players {
                if player.hand == nil {
                    player.hand = [Card]()
                }
                player.hand?.append(cards[index])
                cards.removeLast()
                index -= 1
            }
        }
    }

    public mutating func setTrumpCards(for suit:Suit) {
        for (index, card) in cards.enumerated() {
            if card.suit == suit {
                cards[index].isTrump = true
            }
        }
    }
}

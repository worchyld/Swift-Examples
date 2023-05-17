import Foundation

protocol DeckDelegate: AnyObject {
    associatedtype Element
    var size: Int { get }
    var isEmpty: Bool { get }
    var cards:[Element] { get set }
    func push(_ element: Element)
    func pop() -> Element?
    func shuffle()
}

class Deck<Element> : DeckDelegate {
    var size: Int {
        return cards.count
    }
    var isEmpty: Bool {
        return (cards.count == 0)
    }
    
    internal var cards: [Element] = []
    
    func push(_ element: Element) {
        cards.append(element)
    }
    
    func pop() -> Element? {
        cards.popLast()
    }
    
    func shuffle() {
        cards.shuffle()
    }
}

class TrainDeck : Deck<Card> {
    var rust = 1
}

//struct Deck<Element> : DeckDelegate {
//    var size: Int {
//        return cards.count
//    }
//    var isEmpty: Bool {
//        return (cards.count == 0)
//    }
//
//    internal var cards: [Element] = []
//
//    mutating func push(_ element: Element) {
//        cards.append(element)
//    }
//
//    mutating func pop() -> Element? {
//        cards.popLast()
//    }
//
//    mutating func shuffle() {
//        cards.shuffle()
//    }
//}


extension Deck {
    // read only
    var topItem: Element? {
        return cards.isEmpty ? nil : cards[cards.count - 1]
    }
}

struct Card {
    let name: String
}


var deck = Deck<Card>()
deck.push(Card(name: "Card 1"))
deck.push(Card(name: "Card 2"))
deck.push(Card(name: "Card 3"))
deck.push(Card(name: "Card 4"))

let card = deck.pop()
print (card?.name ?? "No card found")

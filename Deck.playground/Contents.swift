import Foundation

// Generic deck
class Deck<Element> {
    var size: Int {
        return cards.count
    }
    var isEmpty: Bool {
        return (cards.count == 0)
    }

    var topItem: Element? {
        get {
            return cards.isEmpty ? nil : cards[cards.count - 1]
        }
    }
    
    internal var cards: [Element] = []
    
    func push(_ element: Element) {
        cards.append(element)
    }
    
    func pop() -> Element? {
        cards.popLast()
    }
            
    func find(_ card: Element) -> Int? where Element: Equatable {
        cards.firstIndex(of: card)
    }
    
    func shuffle() {
        cards.shuffle()
    }
}

struct Card: Identifiable, Equatable {
    internal let id: UUID = UUID()
    let name: String
}

extension Card : CustomStringConvertible {
    var description: String {
        let idString = String(describing: self.id)
        return ("ID: \(idString), name: \(self.name)")
    }
}


var deck = Deck<Card>()
deck.push(Card(name: "Card 1"))
deck.push(Card(name: "Card 2"))
deck.push(Card(name: "Card 3"))
deck.push(Card(name: "Card 4"))

let card = deck.pop()
print (card?.name ?? "No card found")

class Parent {
    var cards : Deck<Card>
    
    init(cards: Deck<Card>) {
        self.cards = cards
    }
}

let p = Parent(cards: deck)
print (p.cards)

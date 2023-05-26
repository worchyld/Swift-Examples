import Foundation

extension BidirectionalCollection where Iterator.Element: Equatable {
    typealias Element = Self.Iterator.Element

    func after(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = self.firstIndex(of: item) {
            let lastItem: Bool = (index(after:itemIndex) == endIndex)
            if loop && lastItem {
                return self.first
            } else if lastItem {
                return nil
            } else {
                return self[index(after:itemIndex)]
            }
        }
        return nil
    }

    func before(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = self.firstIndex(of: item) {
            let firstItem: Bool = (itemIndex == startIndex)
            if loop && firstItem {
                return self.last
            } else if firstItem {
                return nil
            } else {
                return self[index(before:itemIndex)]
            }
        }
        return nil
    }
}

struct Card: Equatable, Identifiable {
    internal let id: UUID = UUID()
    let value: Int
    let unlocked: Bool
    
    init(value: Int, unlocked: Bool = false) {
        self.value = value
        self.unlocked = unlocked
    }
        
    func toggle() -> Self {
        return .init(value: self.value, unlocked: !self.unlocked)
    }
    
}

let cards = [Card(value: 1), Card(value: 2), Card(value: 3)]

let currentChild = cards[2]
let nextChild = cards.after(currentChild)

func output(item: Card, nextItem: Card? = nil) {
    print("Current card: \(item)")
    print("Next card: \(String(describing: nextItem))")
}

output(item: currentChild, nextItem: nextChild)


import Foundation

enum LocoState: Int, CaseIterable {
    case inactive
    case hasInitialOrder
    case active
    case rusted
    
    mutating func next() {
        self = LocoState(rawValue: rawValue + 1) ?? .rusted
    }
}

public func Die() -> Int {
    return Int.random(in: 1...6)
}

class Locomotive: Identifiable {
    internal let id: UUID = UUID()
    var initialOrder: Int?
    var orders: [Int]
    var sales: [Int]
    var state: LocoState
    let capacity: Int
    
    init(initialOrder: Int? = nil, orders:[Int], sales:[Int], state: LocoState = .inactive, capacity: Int) {
        self.initialOrder = initialOrder
        self.orders = orders
        self.sales = sales
        self.state = state
        self.capacity = capacity
    }
    
    var isFull: Bool {
        return ((self.orders.count + self.sales.count) >= self.capacity)
    }
    var isEmpty: Bool {
        return ((self.orders.count + self.sales.count) == 0)
    }
}

extension Locomotive: CustomDebugStringConvertible {
    var debugDescription: String {
        let initialOrderString = String(describing: self.initialOrder)
        
        return ("\nID: \(id), initialOrder: \(initialOrderString), orders: \(self.orders), sales: \(self.sales), state: \(self.state)")
    }
}

class OrderManager {
    private let loco: Locomotive
    
    init(loco: Locomotive) {
        self.loco = loco
    }
    
    func setInitialOrder(value: Int) {
        guard self.loco.state == .inactive else {
            print ("Loco needs to be inactive")
            return
        }
        self.loco.initialOrder = value
        self.loco.state.next()
    }
    
    func moveInitialOrderToOrder() {
        guard self.loco.state == .hasInitialOrder else {
            print ("Loco must have an initialOrder")
            return
        }
        guard let value = self.loco.initialOrder else {
            print ("Initial Order is nil")
            return
        }
        self.loco.state.next()

        addOrder(value: value)
        self.loco.initialOrder = nil

        print (self.loco.state)
        
        // Unlock the next one
    }
        
    func addOrder(value: Int) {
        guard self.loco.state == .active else {
            print ("Loco isn't active")
            return
        }
        guard !self.loco.isFull else {
            print ("Loco is full")
            return
        }
        self.loco.orders.append(value)
    }
    
    func transferOrderToSale(index: Int) {
        guard self.loco.state == .active else {
            print ("Loco isn't active")
            return
        }
        if self.loco.orders.isEmpty {
            print ("No orders to transfer")
            return
        }
        if (index > self.loco.orders.count) {
            print ("Out of bounds")
            return
        }
        if (index > self.loco.orders.endIndex) {
            print ("Out of bounds")
            return
        }
        
        let value = self.loco.orders[index]
        self.loco.sales.append(value)
        self.loco.orders.remove(at: index)
    }
    
    func transferAllSalesToOrders() {
        guard self.loco.state == .active else {
            print ("Loco isn't active")
            return
        }
        self.loco.sales.enumerated().map { index, item in
            self.addOrder(value: item)
        }
        self.loco.sales.removeAll()
    }
    
    
}

var locos : [Locomotive] = [
    Locomotive.init(initialOrder: nil, orders: [Int](), sales: [Int](), state: .inactive, capacity: 3),
    Locomotive.init(initialOrder: nil, orders: [Int](), sales: [Int](), state: .inactive, capacity: 2)
]

var firstLoco = locos.first! as Locomotive
let om = OrderManager.init(loco: firstLoco)

om.setInitialOrder(value: 1)
om.moveInitialOrderToOrder()
om.addOrder(value: 3)
om.addOrder(value: 5)

om.transferOrderToSale(index: 1)
om.transferOrderToSale(index: 1)

om.transferAllSalesToOrders()

print (locos)




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
            print ("Loco is active or older")
            return
        }
        self.loco.initialOrder = value
        self.loco.state = .hasInitialOrder
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
        addOrder(value: value)
        self.loco.initialOrder = nil
        self.loco.state = .active
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
    
    func transferToSale(value: Int) {
        guard self.loco.state == .active else {
            print ("Loco isn't active")
            return
        }
        guard !self.loco.isFull else {
            print ("Loco is full")
            return
        }
        
        guard let index = self.loco.orders.firstIndex(of: value) else {
            print ("Cannot find index of order")
            return
        }
        self.loco.sales.append(value)
        self.loco.orders.remove(at: index)
    }
    
    func transferAllToOrders() {
        guard self.loco.state == .active else {
            print ("Loco isn't active")
            return
        }
        guard !self.loco.isFull else {
            print ("Loco is full")
            return
        }
    }
    
    
}

var locos : [Locomotive] = [
    Locomotive.init(initialOrder: nil, orders: [Int](), sales: [Int](), state: .inactive, capacity: 3),
    Locomotive.init(initialOrder: nil, orders: [Int](), sales: [Int](), state: .inactive, capacity: 2)
]

var firstLoco = locos.first! as Locomotive
let om = OrderManager.init(loco: firstLoco)
om.setInitialOrder(value: 1)
//print (locos)

om.moveInitialOrderToOrder()

print (locos)

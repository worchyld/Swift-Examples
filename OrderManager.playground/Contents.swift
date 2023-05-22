import Foundation

enum OrderType: Int {
    case initialOrder
    case order
    case sale
}

extension OrderType : CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .initialOrder: return "initialOrder"
        case .order: return "order"
        case .sale: return "sale"
        }
    }
}



struct Order {
    let type: OrderType
    let value: Int
    
    func changeType(to: OrderType, value: Int) -> Self {
        switch to {
        case .initialOrder:
            return .init(type: to, value: value)
        case .order:
            return .init(type: to, value: value)
        case .sale:
            return .init(type: to, value: value)
        }
    }
}



class Locomotive {
    var orders: [Order]
    
    init(orders: [Order] = [Order]() ) {
        self.orders = orders
    }
}

extension Locomotive : CustomDebugStringConvertible {
    var debugDescription: String {
        return ("orders: \(orders)")
    }
}

let loco = Locomotive.init(orders: [Order.init(type: .initialOrder, value: 1)])
print (loco.orders)

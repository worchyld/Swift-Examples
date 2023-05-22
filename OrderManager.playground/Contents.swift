import Foundation

class Locomotive {
    var initialOrder: Int?
    var orders: [Int]
    var sales: [Int]
    
    init(initialOrder: Int? = nil, orders:[Int], sales:[Int]) {
        self.initialOrder = initialOrder
        self.orders = orders
        self.sales = sales
    }
}

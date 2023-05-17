import Foundation

/* Swift playground */
/* Examples of try-catch and throwing errors
 with simple protocols
 */

enum NumericError : Error {
    case cannotBeNegative
    case notEnough(amount: Int)
}

extension NumericError : CustomStringConvertible {
    var description : String {
        switch self {
        case .cannotBeNegative:
            return "Cannot be negative"
        case .notEnough(let amount):
            return "Cannot afford: $\(amount)"
        }
    }
}

protocol Debiting {
    func debit(amount: Int) throws
}
protocol Crediting {
    func credit(amount: Int) throws
}

final class Bank : Crediting, Debiting {
    public private (set) var balance: Int
    
    init(balance: Int = 0) {
        self.balance = balance
    }
    
    func credit(amount: Int) throws {
        do {
            try canCredit(amount: amount)
            
            balance += amount
        } catch let err {
            throw err
        }
    }
    func debit(amount: Int) throws {
        do {
            try canDebit(amount: amount)
            
            balance -= amount
        } catch let err {
            throw err
        }
    }
    
    private func canCredit(amount: Int) throws -> Bool {
        guard amount > 0 else {
            throw NumericError.cannotBeNegative
        }
        return true
    }
    
    private func canDebit(amount: Int) throws -> Bool {
        guard amount > 0 else {
            throw NumericError.cannotBeNegative
        }
        let sum = balance - amount
        guard sum >= 0 else {
            throw NumericError.notEnough(amount: amount)
        }
        return true
    }
}

var cash = 100
var bank = Bank(balance: 100)
try bank.credit(amount: 100)
try bank.debit(amount: 50)

do {
    try bank.credit(amount: -50)
}
catch let err {
    print (err)
}

do {
    try bank.debit(amount: -50)
}
catch let err {
    print (err)
}

do {
    try bank.debit(amount: 250)
}
catch let err {
    print (err)
}

print (bank.balance)

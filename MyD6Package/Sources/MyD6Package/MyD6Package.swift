// The Swift Programming Language
// https://docs.swift.org/swift-book
import GameplayKit

public struct D6 {
    public static func roll() -> Int {
        let value = GameplayKit.GKShuffledDistribution.d6()
        return value.nextInt()
    }
    
    public static func increment(d6: Int, by: Int = 1) -> Int {
        let highestValue = GameplayKit.GKShuffledDistribution.d6().highestValue
        
        let sum = (d6 + by)
        
        guard (sum <= highestValue) else {
            return d6
        }
        
        return sum
    }
    
    public static func decrement(d6: Int, by: Int = 1) -> Int {
        let lowestValue = GameplayKit.GKShuffledDistribution.d6().lowestValue
        
        let sum = d6 - by
        
        guard (sum >= lowestValue) else {
            return d6
        }
        
        return sum
    }
}

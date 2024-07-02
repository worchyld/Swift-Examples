import XCTest
import GameplayKit
@testable import MyD6Package

final class MyD6PackageTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
    
    
    func testD6BoundariesValues() throws {
        let highestValue = GameplayKit.GKShuffledDistribution.d6().highestValue
        let lowestValue = GameplayKit.GKShuffledDistribution.d6().lowestValue
        XCTAssertTrue(highestValue == 6)
        XCTAssertTrue(lowestValue == 1)
    }
    
    func testIncrementBy1() throws {
        var d6 = 3
        d6 = D6.increment(d6: d6, by: 1)
        XCTAssertTrue(d6 == 4)
    }
    
    func testDecrementBy1() throws {
        var d6 = 3
        let expected = 2
        
        d6 = D6.decrement(d6: d6, by: 1)
        XCTAssertTrue(d6 == expected)
    }
    
    func testIncrementSixBy1() throws {
        var d6 = 6
        let expected = 6
        
        d6 = D6.increment(d6: d6, by: 1)
        XCTAssertTrue(d6 == expected)
    }
    
    func testDecrementOneBy1() throws {
        var d6 = 1
        let expected = 1
        
        d6 = D6.decrement(d6: d6, by: 1)
        XCTAssertTrue(d6 == expected)
    }
}

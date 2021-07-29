// Copyright © 2021 Brian Drelling. All rights reserved.

@testable import DiceKit
import XCTest

final class DiceProbabilityTests: XCTestCase {
    // MARK: Constants
    
    private static let defaultDie: Die = .d6
    
    // MARK: Tests
    
    func testProbabilityOfRollingExactValue() {
        let probability = Self.defaultDie.occurrenceProbability(of: .equalTo(3))
        XCTAssertEqual(probability, 1/6)
    }

    func testProbabilityOfRollingGreaterThanValue() {
        let probability = Self.defaultDie.occurrenceProbability(of: .greaterThan(3))
        XCTAssertEqual(probability, 3/6)
    }

    func testProbabilityOfRollingGreaterThanOrEqualToValue() {
        let probability = Self.defaultDie.occurrenceProbability(of: .greaterThanOrEqualTo(3))
        XCTAssertEqual(probability, 4/6)
    }

    func testProbabilityOfRollingLessThanValue() {
        let probability = Self.defaultDie.occurrenceProbability(of: .lessThan(3))
        XCTAssertEqual(probability, 2/6)
    }

    func testProbabilityOfRollingLessThanOrEqualToValue() {
        let probability = Self.defaultDie.occurrenceProbability(of: .lessThanOrEqualTo(3))
        XCTAssertEqual(probability, 3/6)
    }
    
    func testProbabilityOfRollingInvalidValues() {
        let firstProbability = Self.defaultDie.occurrenceProbability(of: .equalTo(0))
        XCTAssertEqual(firstProbability, 0)
        
        let secondProbability = Self.defaultDie.occurrenceProbability(of: .equalTo(7))
        XCTAssertEqual(secondProbability, 0)
    }
}

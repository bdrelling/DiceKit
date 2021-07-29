// Copyright © 2021 Brian Drelling. All rights reserved.

@testable import DiceKit
import XCTest

final class DiceHandProbabilityTests: XCTestCase {
    // MARK: Constants
    
    private static let defaultHand: DiceHand = [.d6, .d6]
    
    // MARK: Tests
    
    // MARK: Occurrence Probabilities
    
    func testOccurrenceProbabilityOfRollingExactValues() {
        let firstProbability = Self.defaultHand.occurrenceProbability(of: .equalTo(3))
        XCTAssertEqual(firstProbability, (1/6) * 2)
    }

    func testOccurrenceProbabilityOfRollingGreaterThanValue() {
        let probability = Self.defaultHand.occurrenceProbability(of: .greaterThan(3))
        XCTAssertEqual(probability, (3/6) * 2)
    }

    func testOccurrenceProbabilityOfRollingGreaterThanOrEqualToValue() {
        let probability = Self.defaultHand.occurrenceProbability(of: .greaterThanOrEqualTo(3))
        XCTAssertEqual(probability, (4/6) * 2)
    }

    func testOccurrenceProbabilityOfRollingLessThanValue() {
        let probability = Self.defaultHand.occurrenceProbability(of: .lessThan(3))
        XCTAssertEqual(probability, (2/6) * 2)
    }

    func testOccurrenceProbabilityOfRollingLessThanOrEqualToValue() {
        let probability = Self.defaultHand.occurrenceProbability(of: .lessThanOrEqualTo(3))
        XCTAssertEqual(probability, (3/6) * 2)
    }
    
    func testOccurrenceProbabilityOfRollingInvalidValues() {
        let firstProbability = Self.defaultHand.occurrenceProbability(of: .equalTo(0))
        XCTAssertEqual(firstProbability, 0)
        
        let secondProbability = Self.defaultHand.occurrenceProbability(of: .equalTo(7))
        XCTAssertEqual(secondProbability, 0)
    }
    
    // MARK: Score Probabilities
    
    func testScoreProbabilityOfRollingExactValues() {
        let firstProbability = Self.defaultHand.scoreProbability(of: .equalTo(3))
        XCTAssertEqual(firstProbability, 2 / 36)
        
        let secondProbability = Self.defaultHand.scoreProbability(of: .equalTo(7))
        XCTAssertEqual(secondProbability, 6 / 36)
    }

    func testScoreProbabilityOfRollingGreaterThanValue() {
        let probability = Self.defaultHand.scoreProbability(of: .greaterThan(8))
        XCTAssertEqual(probability, 10 / 36)
    }

    func testScoreProbabilityOfRollingGreaterThanOrEqualToValue() {
        let probability = Self.defaultHand.scoreProbability(of: .greaterThanOrEqualTo(8))
        XCTAssertEqual(probability, 15 / 36)
    }

    func testScoreProbabilityOfRollingLessThanValue() {
        let probability = Self.defaultHand.scoreProbability(of: .lessThan(8))
        XCTAssertEqual(probability, 21 / 36)
    }

    func testScoreProbabilityOfRollingLessThanOrEqualToValue() {
        let probability = Self.defaultHand.scoreProbability(of: .lessThanOrEqualTo(8))
        XCTAssertEqual(probability, 26 / 36)
    }
    
    func testScoreProbabilityOfRollingInvalidValues() {
        let firstProbability = Self.defaultHand.scoreProbability(of: .equalTo(1))
        XCTAssertEqual(firstProbability, 0)
        
        let secondProbability = Self.defaultHand.scoreProbability(of: .equalTo(13))
        XCTAssertEqual(secondProbability, 0)
    }
}

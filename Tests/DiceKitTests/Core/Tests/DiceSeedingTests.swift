// Copyright © 2021 Brian Drelling. All rights reserved.

@testable import DiceKit
import XCTest

final class DiceSeedingTests: XCTestCase {
    // MARK: Constants
    
    private static let defaultSeed = 420
    
    // MARK: Tests

    func testNonSeededDiceProduceDifferentResults() {
        // GIVEN: We have two different non-seeded dice.
        let firstDie: Die = .d20()
        let secondDie: Die = .d20()

        // WHEN: We roll the dice 5 times.
        let numberOfRolls = 5
        let firstResults = firstDie.roll(numberOfRolls)
        let secondResults = secondDie.roll(numberOfRolls)

        // THEN: We expect the dice to have different seed values.
        XCTAssertNotEqual(firstDie.seed, secondDie.seed)

        // THEN: We expect a different set of results from each each die.
        XCTAssertNotEqual(firstResults, secondResults)
    }

    func testSeededDieProducesConsistentResults() {
        // GIVEN: We have a die seeded with an Integer value.
        let die: Die = .d20(seed: Self.defaultSeed)

        // WHEN: We roll the die 10 times.
        let actualResults = die.roll(10)

        let expectedResults = [
            12,
            13,
            2,
            19,
            6,
            16,
            12,
            20,
            17,
            10,
        ]

        // THEN: We expect the same 10 results each time.
        XCTAssertEqual(actualResults, expectedResults)
    }

    // MARK: String Seeding

    func testStringSeededDieProducesConsistentSeed() {
        // GIVEN: We have a die seeded with an String value.
        let die: Die = .d20(seed: "DiceGame")

        // THEN: The seed value is consistent.
        XCTAssertEqual(die.seed, 7379559652864617737)
    }
}

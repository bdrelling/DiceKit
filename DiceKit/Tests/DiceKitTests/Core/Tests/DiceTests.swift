// Copyright © 2021 Brian Drelling. All rights reserved.

@testable import DiceKit
import XCTest

final class DiceTests: XCTestCase {
    private let defaultSeed = 420

    // MARK: No Seeding

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

    // MARK: Integer Seeding

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

    // MARK: Rolling

    func testRollSucceeds() {
        // Setup
        let expectedResult = 12

        // GIVEN: We have a seeded die.
        let die: Die = .d20(seed: Self.defaultSeed)

        // WHEN: We roll the die once.
        let actualResult = die.roll()

        // THEN: The result is consistent.
        XCTAssertEqual(actualResult, expectedResult)

        // THEN: The die's latest value matches the expected result.
        XCTAssertEqual(die.latestValue, expectedResult)
    }

    func testSingleRollPublishesLatestValueSuccessfully() {
        // Setup
        let expectation = self.expectation(description: "Roll the dice one.")
        let expectedResult = 12

        // GIVEN: We have a seeded die.
        let die: Die = .d20(seed: Self.defaultSeed)

        // Initialie the publisher
        let publisher = die.$latestValue
            // Drop the first value, which the die was initialized with.
            .dropFirst()
            .sink { value in
                // We have rolled the die.
                expectation.fulfill()

                // THEN: The published value matches the value of the latest roll.
                XCTAssertEqual(value, expectedResult)
            }

        // WHEN: We roll the die once.
        die.roll()

        // THEN: The publisher is not nil.
        XCTAssertNotNil(publisher)

        // Wait for all expectations to complete.
        self.wait(for: [expectation], timeout: 1)
    }

    func testMultipleRollsPublishLatestValueSuccessfully() {
        // Setup
        let expectation = self.expectation(description: "Roll the dice multiple times.")
        let numberOfRolls = 10
        let expectedResult = 10

        // GIVEN: We have seeded die.
        let die: Die = .d20(seed: Self.defaultSeed)

        // Initialie the publisher
        let publisher = die.$latestValue
            // Drop the first value, which the die was initialized with.
            .dropFirst(numberOfRolls)
            .sink { value in
                // We have rolled the die.
                expectation.fulfill()

                // THEN: The published value matches the value of the latest roll.
                XCTAssertEqual(value, expectedResult)
            }

        // WHEN: We roll the die multiple times.
        die.roll(numberOfRolls)

        // THEN: The publisher is not nil.
        XCTAssertNotNil(publisher)

        // Wait for all expectations to complete.
        self.wait(for: [expectation], timeout: 1)
    }

    // MARK: Rolling and Summing

    func testRollAndSumSuceeds() {
        // Setup
        let expectedSum = 127

        // GIVEN: We have a seeded die.
        let die: Die = .d20(seed: Self.defaultSeed)

        // WHEN: We roll the die ten times and sum the values together.
        let actualSum = die.rollAndSum(10)

        // THEN: The sum is consistent
        XCTAssertEqual(actualSum, expectedSum)
    }

    func testRollAndSumPublishesLatestValueSuccessfully() {
        // Setup
        let expectation = self.expectation(description: "Roll the dice multiple times and sums the values.")
        let numberOfRolls = 10
        let expectedResult = 10

        // GIVEN: We have a seeded die.
        let die: Die = .d20(seed: Self.defaultSeed)

        // Initialize the publisher
        let publisher = die.$latestValue
            // Evaluate only the last value.
            .dropFirst(numberOfRolls)
            .sink { value in
                // We have rolled the die.
                expectation.fulfill()

                // THEN: The published value matches the value of the latest roll.
                XCTAssertEqual(value, expectedResult)
            }

        // WHEN: We roll the die multiple times.
        die.rollAndSum(numberOfRolls)

        // THEN: The publisher is not nil.
        XCTAssertNotNil(publisher)

        // Wait for all expectations to complete.
        self.wait(for: [expectation], timeout: 1)
    }

    // MARK: Probabilities

    func testProbabilities() {
        let die: Die = .d6(seed: Self.defaultSeed)
    }
}

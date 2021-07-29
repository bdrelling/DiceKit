// Copyright © 2021 Brian Drelling. All rights reserved.

@testable import DiceKit
import XCTest

final class DiceRollingTests: XCTestCase {
    // MARK: Constants
    
    private static let defaultSeed = 420
    
    // MARK: Tests
    
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
}

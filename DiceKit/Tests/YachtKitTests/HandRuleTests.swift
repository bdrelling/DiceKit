// Copyright © 2021 Brian Drelling. All rights reserved.

import DiceKit
import XCTest
@testable import YachtKit

final class HandRuleTests: XCTestCase {
    // MARK: - Ones

    func testEvaluatingOnesSucceeds() throws {
        let values = [1, 1, 6, 1, 1]
        let results = HandRule.ones.evaluate(values)

        // THEN: There should be only one result.
        XCTAssertEqual(results, [
            .ones(count: 4),
        ])
    }

    // MARK: - Twos

    func testEvaluatingTwosSucceeds() throws {
        let values = [1, 2, 1, 2, 1]
        let results = HandRule.twos.evaluate(values)

        // THEN: There should be only one result.
        XCTAssertEqual(results, [
            .twos(count: 2),
        ])
    }

    // MARK: - Threes

    func testEvaluatingThreesSucceeds() throws {
        let values = [3, 1, 3, 1, 3]
        let results = HandRule.threes.evaluate(values)

        // THEN: There should be only one result.
        XCTAssertEqual(results, [
            .threes(count: 3),
        ])
    }

    // MARK: - Fours

    func testEvaluatingFoursSucceeds() throws {
        let values = [4, 4, 2, 2, 2]
        let results = HandRule.fours.evaluate(values)

        // THEN: There should be only one result.
        XCTAssertEqual(results, [
            .fours(count: 2),
        ])
    }

    // MARK: - Fives

    func testEvaluatingFivesSucceeds() throws {
        let values = [5, 1, 2, 3, 4]
        let results = HandRule.fives.evaluate(values)

        // THEN: There should be only one result.
        XCTAssertEqual(results, [
            .fives(count: 1),
        ])
    }

    // MARK: - Sixes

    func testEvaluatingSixesSucceeds() throws {
        let values = [6, 3, 6, 2, 6]
        let results = HandRule.sixes.evaluate(values)

        // THEN: There should be only one result.
        XCTAssertEqual(results, [
            .sixes(count: 3),
        ])
    }

    // MARK: - Full House

    func testEvaluatingFullHouseSucceeds() throws {
        let values = [2, 2, 3, 3, 3]
        let results = HandRule.fullHouse.evaluate(values)

        // THEN: There should be only one result.
        XCTAssertEqual(results, [
            .fullHouse(majority: [3, 3, 3], minority: [2, 2]),
        ])
    }

    // MARK: - FourOfAKind

    func testEvaluatingFourOfAKindSucceeds() throws {
        let values = [2, 3, 3, 3, 3]
        let results = HandRule.fourOfAKind.evaluate(values)

        // THEN: There should be only one result.
        XCTAssertEqual(results, [
            .fourOfAKind(of: 3),
        ])
    }

    // MARK: - Yacht

    func testEvaluatingYachtSucceeds() throws {
        let values = [6, 6, 6, 6, 6]
        let results = HandRule.yacht.evaluate(values)

        // THEN: There should be only one result.
        XCTAssertEqual(results, [
            .yacht(of: 6),
        ])
    }

    func testEvaluatingYachtFails() throws {
        let values = [6, 6, 6, 6, 2]
        let results = HandRule.yacht.evaluate(values)

        // THEN: There should be no results.
        XCTAssertTrue(results.isEmpty)
    }

    // MARK: - Little Straight

    func testEvaluatingLittleStraightSucceeds() throws {
        let values = [5, 3, 1, 4, 2]
        let results = HandRule.littleStraight.evaluate(values)

        // THEN: There should be only one result.
        XCTAssertEqual(results, [
            .littleStraight(),
        ])
    }

    func testEvaluatingLittleStraightFails() throws {
        let values = [1, 1, 1, 1, 1]
        let results = HandRule.littleStraight.evaluate(values)

        // THEN: There should be no results.
        XCTAssertTrue(results.isEmpty)
    }

    // MARK: - Big Straight

    func testEvaluatingBigStraightSucceeds() throws {
        let values = [6, 4, 2, 5, 3]
        let results = HandRule.bigStraight.evaluate(values)

        // THEN: There should be only one result.
        XCTAssertEqual(results, [
            .bigStraight(),
        ])
    }

    func testEvaluatingBigStraightFails() throws {
        let values = [1, 1, 1, 1, 1]
        let results = HandRule.bigStraight.evaluate(values)

        // THEN: There should be no results.
        XCTAssertTrue(results.isEmpty)
    }

    // MARK: - Choice

    func testEvaluatingChoiceSucceeds() throws {
        let values = [6, 2, 3, 5, 1]
        let results = HandRule.choice.evaluate(values)

        // THEN: There should be only one result.
        XCTAssertEqual(results, [
            .choice(of: values),
        ])
    }

    // MARK: - Invalid Hand

    func testEvaluatingInvalidHandFails() throws {
        let values = [0, 0, 0, 0, 0]

        let results = [
            HandRule.ones.evaluate(values),
            HandRule.twos.evaluate(values),
            HandRule.threes.evaluate(values),
            HandRule.fours.evaluate(values),
            HandRule.fives.evaluate(values),
            HandRule.sixes.evaluate(values),
        ].flatMap { $0 }

        // THEN: There should be no results.
        XCTAssertTrue(results.isEmpty)
    }
}

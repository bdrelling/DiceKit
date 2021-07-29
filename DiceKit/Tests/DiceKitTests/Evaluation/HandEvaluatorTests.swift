// Copyright © 2021 Brian Drelling. All rights reserved.

@testable import DiceKit
import XCTest

final class HandEvaluatorTests: XCTestCase {
    func testEvaluatingSucceeds() throws {
        let evaluator: HandEvaluator = .default
        let hand = [1, 1, 2, 2, 5]
        let results = evaluator.evaluate(hand)

        // THEN: There should be three results.
        self.assertEqualIgnoringOrder(results, [
            .highValue(of: 5),
            .set(of: 1, count: 2),
            .set(of: 2, count: 2),
        ])
    }

    func testEvaluatingDiceWithInitialValuesSucceeds() throws {
        let evaluator: HandEvaluator = .default
        let hand: DiceHand = [1, 1, 2, 2, 5].map { .d6(initialValue: $0) }

        let results = evaluator.evaluate(hand)

        // THEN: There should be three results.
        self.assertEqualIgnoringOrder(results, [
            .highValue(of: 5),
            .set(of: 1, count: 2),
            .set(of: 2, count: 2),
        ])
    }

    func testEvaluatingSeededDiceSucceeds() throws {
        let evaluator: HandEvaluator = .default
        let hand: DiceHand = [
            .d6(seed: 1),
            .d6(seed: 2),
            .d6(seed: 3),
            .d6(seed: 4),
            .d6(seed: 5),
        ]

        hand.roll()

        let results = evaluator.evaluate(hand)

        // THEN: There should be three results.
        self.assertEqualIgnoringOrder(results, [
            .highValue(of: 6),
            .set(of: 1, count: 2),
        ])
    }
}

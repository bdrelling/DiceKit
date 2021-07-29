// Copyright © 2021 Brian Drelling. All rights reserved.

@testable import DiceKit
import XCTest

final class HandRuleTests: XCTestCase {
    func testEvaluatingHighValueRuleSucceeds() throws {
        let results = HandRule.highValue.evaluate([1, 1, 2, 2, 5])

        // THEN: There should only be one result.
        self.assertEqualIgnoringOrder(results, [
            .highValue(of: 5),
        ])
    }

    func testEvaluatingSetRuleSucceeds() throws {
        let results = HandRule.set.evaluate([1, 1, 2, 2, 5])

        // THEN: There should be two results.
        self.assertEqualIgnoringOrder(results, [
            .set(of: 1, count: 2),
            .set(of: 2, count: 2),
        ])
    }
}

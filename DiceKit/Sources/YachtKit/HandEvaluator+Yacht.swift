// Copyright © 2021 Brian Drelling. All rights reserved.

import DiceKit

public extension HandEvaluator {
    static var yacht: HandEvaluator<Int> {
        .init(rules: .yacht)
    }
}

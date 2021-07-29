// Copyright © 2021 Brian Drelling. All rights reserved.

import DiceKit

public extension Array where Element == HandRule<Int> {
    static let yacht: [HandRule<Int>] = [
        .ones,
        .twos,
        .threes,
        .fours,
        .fives,
        .sixes,
        .fullHouse,
        .fourOfAKind,
        .yacht,
        .littleStraight,
        .bigStraight,
        .choice,
    ]
}

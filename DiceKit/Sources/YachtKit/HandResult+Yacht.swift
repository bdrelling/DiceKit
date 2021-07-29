// Copyright © 2021 Brian Drelling. All rights reserved.

import DiceKit

public extension HandResult {
    /// Any combination of ones. Scored by the sum of all ones.
    /// - Parameter count: The total count of dice matching this value.
    /// - Returns: A result representing an evaluated hand.
    static func ones(count: Int) -> HandResult<Int> {
        let values = [Int](repeating: 1, count: count)
        return .init(name: "Ones", includedValues: values, score: values.reduce(0, +))
    }

    /// Any combination of twos. Scored by the sum of all twos.
    /// - Parameter count: The total count of dice matching this value.
    /// - Returns: A result representing an evaluated hand.
    static func twos(count: Int) -> HandResult<Int> {
        let values = [Int](repeating: 2, count: count)
        return .init(name: "Twos", includedValues: values, score: values.reduce(0, +))
    }

    /// Any combination of threes. Scored by the sum of all threes.
    /// - Parameter count: The total count of dice matching this value.
    /// - Returns: A result representing an evaluated hand.
    static func threes(count: Int) -> HandResult<Int> {
        let values = [Int](repeating: 3, count: count)
        return .init(name: "Threes", includedValues: values, score: values.reduce(0, +))
    }

    /// Any combination of fours. Scored by the sum of all fours.
    /// - Parameter count: The total count of dice matching this value.
    /// - Returns: A result representing an evaluated hand.
    static func fours(count: Int) -> HandResult<Int> {
        let values = [Int](repeating: 4, count: count)
        return .init(name: "Fours", includedValues: values, score: values.reduce(0, +))
    }

    /// Any combination of fives. Scored by the sum of all fives.
    /// - Parameter count: The total count of dice matching this value.
    /// - Returns: A result representing an evaluated hand.
    static func fives(count: Int) -> HandResult<Int> {
        let values = [Int](repeating: 5, count: count)
        return .init(name: "Fives", includedValues: values, score: values.reduce(0, +))
    }

    /// Any combination of sixes. Scored by the sum of all sixes.
    /// - Parameter count: The total count of dice matching this value.
    /// - Returns: A result representing an evaluated hand.
    static func sixes(count: Int) -> HandResult<Int> {
        let values = [Int](repeating: 6, count: count)
        return .init(name: "Sixes", includedValues: values, score: values.reduce(0, +))
    }

    /// Three of one value, two of another. Scored by the sum of all dice.
    /// - Parameters:
    ///   - majority: The larger set of values representing the majority.
    ///   - minority: The smaller set of values representing the minority.
    /// - Returns: A result representing an evaluated hand.
    static func fullHouse(majority: [Int], minority: [Int]) -> HandResult<Int> {
        let values = majority + minority
        return .init(name: "Full House", includedValues: values, score: values.reduce(0, +))
    }

    /// At least four dice showing the same value. Scored by the sum of those four dice.
    /// - Parameter value: The value of the dice.
    /// - Returns: A result representing an evaluated hand.
    static func fourOfAKind(of value: Int) -> HandResult<Int> {
        let values = [Int](repeating: value, count: 4)
        return .init(name: "Four of a Kind", includedValues: values, score: values.reduce(0, +))
    }

    /// All five dice showing the same value. Scored by a constant value of `50`.
    /// - Parameter value: The value of the dice.
    /// - Returns: A result representing an evaluated hand.
    static func yacht(of value: Int) -> HandResult<Int> {
        let values = [Int](repeating: value, count: 5)
        return .init(name: "Yacht", includedValues: values, score: values.reduce(0, +))
    }

    /// A straight including all five dice that ranges from 1-5. Scored by the sum of all dice (always `15`).
    /// - Returns: A result representing an evaluated hand.
    static func littleStraight() -> HandResult<Int> {
        let values = [1, 2, 3, 4, 5]
        return .init(name: "Little Straight", includedValues: values, score: values.reduce(0, +))
    }

    /// A straight including all five dice that ranges from 2-6. Scored by the sum of all dice (always `20`).
    /// - Returns: A result representing an evaluated hand.
    static func bigStraight() -> HandResult<Int> {
        let values = [2, 3, 4, 5, 6]
        return .init(name: "Big Straight", includedValues: values, score: values.reduce(0, +))
    }

    /// Any combination of dice. Scored by the sum of all dice.
    /// - Returns: A result representing an evaluated hand.
    static func choice(of values: [Int]) -> HandResult<Int> {
        .init(name: "Choice", includedValues: values, score: values.reduce(0, +))
    }
}

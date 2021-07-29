// Copyright © 2021 Brian Drelling. All rights reserved.

import DiceKit

public extension HandRule where Element == Int {
    static let ones: Self = .init { values in
        let count = values.filter { $0 == 1 }.count
        return count > 0 ? [.ones(count: count)] : []
    }

    static let twos: Self = .init { values in
        let count = values.filter { $0 == 2 }.count
        return count > 0 ? [.twos(count: count)] : []
    }

    static let threes: Self = .init { values in
        let count = values.filter { $0 == 3 }.count
        return count > 0 ? [.threes(count: count)] : []
    }

    static let fours: Self = .init { values in
        let count = values.filter { $0 == 4 }.count
        return count > 0 ? [.fours(count: count)] : []
    }

    static let fives: Self = .init { values in
        let count = values.filter { $0 == 5 }.count
        return count > 0 ? [.fives(count: count)] : []
    }

    static let sixes: Self = .init { values in
        let count = values.filter { $0 == 6 }.count
        return count > 0 ? [.sixes(count: count)] : []
    }

    static let fullHouse: Self = .init { values in
        // Group all of our values together.
        let groups = Dictionary(grouping: values, by: { $0 })
            // Sort them by group size, descending.
            .sorted { $0.value.count > $1.value.count }

        // A full house can only have exactly two groups of unique values.
        guard groups.count == 2 else {
            return []
        }

        let majority = groups[0].value
        let minority = groups[1].value

        return [.fullHouse(majority: majority, minority: minority)]
    }

    static let fourOfAKind: Self = .init { values in
        // Group all of our values together.
        Dictionary(grouping: values, by: { $0 })
            // Grab the value represented exactly four times in the array.
            .filter { $0.value.count == 4 }
            // Map the values to a four of a kind result.
            .map { .fourOfAKind(of: $0.key) }
    }

    static let yacht: Self = .init { values in
        // A yacht represents an entire hand consisting of a single value.
        // Therefore if there is more than one value when converted into a set, there is not a yacht.
        guard let value = values.first, values.allSatisfy({ $0 == value }) else {
            return []
        }

        return [.yacht(of: value)]
    }

    static let littleStraight: Self = .init { values in
        if values.sorted() == [1, 2, 3, 4, 5] {
            return [.littleStraight()]
        } else {
            return []
        }
    }

    static let bigStraight: Self = .init { values in
        if values.sorted() == [2, 3, 4, 5, 6] {
            return [.bigStraight()]
        } else {
            return []
        }
    }

    static let choice: Self = .init { values in
        [.choice(of: values)]
    }
}

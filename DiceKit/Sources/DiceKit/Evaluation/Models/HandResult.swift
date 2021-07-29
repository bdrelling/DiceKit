// Copyright © 2021 Brian Drelling. All rights reserved.

import Foundation

public struct HandResult<T> {
    public typealias Element = T

    public let name: String
    public let description: String
    public let includedValues: [Element]
    public let score: Int?

    public init(name: String, includedValues: [Element], description: String? = nil, score: Int? = nil) {
        self.name = name
        self.description = description ?? name
        self.includedValues = includedValues
        self.score = score
    }
}

extension HandResult: Equatable where Element: Equatable {}
extension HandResult: Hashable where Element: Hashable {}

extension HandResult: Comparable where Element: Comparable {
    public static func < (lhs: HandResult<Element>, rhs: HandResult<Element>) -> Bool {
        // First, sort by the score. If there is no score, evaluate using a constant zero value.
        lhs.score ?? 0 < rhs.score ?? 0
            // Then, sort by the name to avoid sorting issues.
            && lhs.name < rhs.name
            // Then, sort by the description to avoid sorting issues.
            && lhs.description < rhs.description
    }
}

public extension HandResult {
    static func highValue(of value: T) -> Self {
        .init(name: "High Value", includedValues: [value], description: "High Value of \(value)")
    }

    static func set(of value: T, count: Int) -> Self {
        let values = [T](repeating: value, count: count)

        let numberFormatter = NumberFormatter()
        numberFormatter.locale = .init(identifier: "en_US_POSIX")
        numberFormatter.numberStyle = .spellOut

        let countText = numberFormatter.string(from: NSNumber(value: count))?.capitalized ?? String(count)

        return .init(name: "Set", includedValues: values, description: "\(countText) of a Kind, \(value)'s")
    }

//    static func sequence(of values: [T]) -> HandResult<T> {
//
//    }
}

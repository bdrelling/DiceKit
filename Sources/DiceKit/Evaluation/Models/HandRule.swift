// Copyright © 2021 Brian Drelling. All rights reserved.

public struct HandRule<T> {
    public typealias Element = T
    public typealias Result = HandResult<T>
    public typealias EvaluationBlock = ([T]) -> [Result]

    public let evaluate: EvaluationBlock

    public init(_ evaluation: @escaping EvaluationBlock) {
        self.evaluate = evaluation
    }

    // Royal Flush:
    // A straight flush of the __top five cards of any suit__. This is generally the highest possible hand.
}

public extension HandRule where Element == Int {
    static let set: Self = .init { values in
        // Group all values together.
        Dictionary(grouping: values, by: { $0 })
            // Remove any values that don't exist two or more times in our array.
            .filter { $0.value.count > 1 }
            // Map the values to a HandResult.
            .map { Result.set(of: $0.key, count: $0.value.count) }
    }

    static let highValue: Self = .init { values in
        if let maxValue = values.max() {
            return [.highValue(of: maxValue)]
        } else {
            return []
        }
    }
}

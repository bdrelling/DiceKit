// Copyright © 2021 Brian Drelling. All rights reserved.

public typealias DiceEvaluator = HandEvaluator<Int>

public final class HandEvaluator<T> {
    public typealias Element = T
    public typealias Rule = HandRule<T>
    public typealias Result = HandResult<T>

    private let rules: [Rule]

    public init(rules: [Rule]) {
        self.rules = rules
    }

    public func evaluate(_ values: [Element]) -> [Result] {
        self.rules.flatMap { $0.evaluate(values) }
    }
}

public extension HandEvaluator {
    static var `default`: HandEvaluator<Int> {
        .init(rules: [.highValue, .set])
    }
}

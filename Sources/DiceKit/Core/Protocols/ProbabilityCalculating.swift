// Copyright © 2021 Brian Drelling. All rights reserved.

public protocol ProbabilityCalculating {
    var singleRollProbability: Float { get} 
    
    func occurrenceProbability(of condition: ProbabilityCondition) -> Float
    func scoreProbability(of condition: ProbabilityCondition) -> Float
}

// MARK: - Supporting Types

public enum ProbabilityCondition {
    case equalTo(Int)
    case greaterThan(Int)
    case greaterThanOrEqualTo(Int)
    case lessThan(Int)
    case lessThanOrEqualTo(Int)

    var value: Int {
        switch self {
        case let .equalTo(value),
             let .greaterThan(value),
             let .greaterThanOrEqualTo(value),
             let .lessThan(value),
             let .lessThanOrEqualTo(value):
            return value
        }
    }
}

// MARK: - Extensions

public extension ProbabilityCalculating {
    func occurrencProbability(of value: Int) -> Float {
        self.occurrenceProbability(of: .equalTo(value))
    }
    
    func scoreProbability(of value: Int) -> Float {
        self.scoreProbability(of: .equalTo(value))
    }
}

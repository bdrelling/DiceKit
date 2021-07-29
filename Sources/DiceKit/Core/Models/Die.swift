// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine
import GameplayKit

/// Represents a single dice with a specific number of sides.
public final class Die: ObservableObject, Identifiable {
    // MARK: - Constants

    /// The value of the die when it is first initialized.
    public static let defaultStartingValue = 1

    /// Represents the minimum number of sides a die can be created with.
    /// A die cannot have fewer than 2 sides (in an abstract sense).
    public static let minimumNumberOfSides = 2

    // MARK: - Properties

    /// The value of the latest roll of this die.
    @Published public private(set) var latestValue: Int

    /// The number of sides on the die.
    @Bounded(Die.minimumNumberOfSides...) public private(set) var sides: Int

    /// Whether or not the die can be rolled.
    @Published public private(set) var isFrozen: Bool = false

    /// The identifier of the `Die`.
    public let id = UUID()

    /// The minimum possible value of a roll.
    /// At time of writing this value is constant, but implementation allows forwards-compatibility.
    public let minimumValue: Int = 1

    /// The seeded generator to use.
    private var generator: SeededGenerator

    // MARK: - Computed Properties

    /// The maximum possible value of a roll.
    /// This property is an alias for `sides`.
    public var maximumValue: Int {
        self.sides
    }
    
    /// The average value of a roll.
    var averageValue: Float {
        Float(self.maximumValue + self.minimumValue) / 2
    }

    /// The unbounded range of possible values.
    public var range: ClosedRange<Int> {
        self.minimumValue ... self.maximumValue
    }

    /// The underlying seed used for random number generation.
    public var seed: UInt64 {
        self.generator.seed
    }

    // MARK: - Methods

    // MARK: Initializers

    /// Creates a new die with a given number of sides and an optional seed value.
    /// - Parameters:
    ///   - sides: The number of sides for the die.
    ///            By default, this represents the maximum possible roll value.
    ///   - initialValue: The initial value of the die when it is first created.
    ///   - seed: The seed to use for underlying random number generation.
    ///           Defaults to `nil`, which creates a random seed.
    public init(sides: Int, initialValue: Int = Die.defaultStartingValue, seed: Seed? = nil) {
        self.generator = .init(seed: seed)
        self.latestValue = initialValue

        self.sides = sides
    }

    // MARK: Rolling

    /// Rolls the die, generating and returning the value.
    /// The latest roll's value can also be accessed via the `value` property.
    /// - Returns: The result of the roll. The result of a roll can be from `1` up to the number of `sides`.
    @discardableResult
    public func roll() -> Int {
        guard !self.isFrozen else {
            // TODO: Return a more meaningful value, potentially even nil?
            return 0
        }

        // Get a random number for the provided range using the seeded random number generator.
        let result = Int.random(in: self.range, using: &self.generator)

        // Set the current value of the die to the result of the roll.
        // This will be published to any subscribers listening to the roesults of rolls by this die.
        self.latestValue = result

        // Return the result.
        return result
    }

    /// Rolls the die multiple times, generating and returning the results of all rolls.
    /// The latest roll's value can also be accessed via the `value` property.
    /// - Parameter repetitions: The number of times to roll the die.
    /// - Returns: The results of all rolls. The result of a roll can be from `1` up to the number of `sides`.
    @discardableResult
    public func roll(_ repetitions: Int) -> [Int] {
        guard !self.isFrozen else {
            return []
        }

        return (0 ..< repetitions).map { _ in self.roll() }
    }

    /// Rolls the die multiple times, generating and returning the sum of all rolls.
    /// The latest roll's value can also be accessed via the `value` property.
    /// - Parameter repetitions: The number of times to roll the die.
    /// - Returns: The sum of all rolls.
    @discardableResult
    public func rollAndSum(_ repetitions: Int) -> Int {
        guard !self.isFrozen else {
            // TODO: Return a more meaningful value, potentially even nil?
            return 0
        }

        return self.roll(repetitions).reduce(0, +)
    }

    // MARK: Freezing

    public func freeze() {
        self.isFrozen = true
    }

    /// Toggles the `isFrozen` `Bool` property of the `Die`.
    public func toggleFreeze() {
        self.isFrozen.toggle()
    }

    public func unfreeze() {
        self.isFrozen = false
    }

    // MARK: Utilities

    private func isValid(value: Int) -> Bool {
        value >= self.minimumValue && value <= self.maximumValue
    }
}

// MARK: - Extensions

extension Die: ProbabilityCalculating {
    /// The probability of rolling any specific value.
    /// This value is always equal to 1 divided by the number of sides.
    public var singleRollProbability: Float {
        1 / Float(self.maximumValue)
    }
    
    public func occurrenceProbability(of condition: ProbabilityCondition) -> Float {
        self.scoreProbability(of: condition)
    }
    
    public func scoreProbability(of condition: ProbabilityCondition) -> Float {
        guard self.isValid(value: condition.value) else {
            return 0
        }

        switch condition {
        case .equalTo:
            return self.singleRollProbability
        case let .greaterThan(value):
            return Float(self.maximumValue - value) / Float(self.maximumValue)
        case let .greaterThanOrEqualTo(value):
            return Float(self.maximumValue - value + 1) / Float(self.maximumValue)
        case let .lessThan(value):
            return Float(value - 1) / Float(self.maximumValue)
        case let .lessThanOrEqualTo(value):
            return Float(value) / Float(self.maximumValue)
        }
    }
}

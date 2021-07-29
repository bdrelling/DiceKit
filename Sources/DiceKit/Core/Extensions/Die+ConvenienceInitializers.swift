// Copyright © 2021 Brian Drelling. All rights reserved.

public extension Die {
    // MARK: d4

    /// Initializes a new four-sided die.
    static var d4: Die {
        .init(sides: 4)
    }

    /// Initializes a new four-sided die with a given seed.
    /// - Parameters:
    ///   - initialValue: The initial value of the die when it is first created.
    ///   - seed: The random number generation seed to use for the
    ///           Defaults to `nil`, which will result in a random seed being created and used.
    /// - Returns: A new four-sided die.
    static func d4(initialValue: Int = Die.defaultStartingValue, seed: Seed? = nil) -> Die {
        .init(sides: 4, initialValue: initialValue, seed: seed)
    }

    // MARK: d6

    /// Initializes a new six-sided die.
    static var d6: Die {
        .init(sides: 6)
    }

    /// Initializes a new six-sided die with a given seed.
    /// - Parameters:
    ///   - initialValue: The initial value of the die when it is first created.
    ///   - seed: The random number generation seed to use for the
    ///           Defaults to `nil`, which will result in a random seed being created and used.
    /// - Returns: A new six-sided die.
    static func d6(initialValue: Int = Die.defaultStartingValue, seed: Seed? = nil) -> Die {
        .init(sides: 6, initialValue: initialValue, seed: seed)
    }

    // MARK: d8

    /// Initializes a new eight-sided die.
    static var d8: Die {
        .init(sides: 8)
    }

    /// Initializes a new eight-sided die with a given seed.
    /// - Parameters:
    ///   - initialValue: The initial value of the die when it is first created.
    ///   - seed: The random number generation seed to use for the
    ///           Defaults to `nil`, which will result in a random seed being created and used.
    /// - Returns: A new eight-sided die.
    static func d8(initialValue: Int = Die.defaultStartingValue, seed: Seed? = nil) -> Die {
        .init(sides: 8, initialValue: initialValue, seed: seed)
    }

    // MARK: d10

    /// Initializes a new ten-sided die.
    static var d10: Die {
        .init(sides: 10)
    }

    /// Initializes a new ten-sided die with a given seed.
    /// - Parameters:
    ///   - initialValue: The initial value of the die when it is first created.
    ///   - seed: The random number generation seed to use for the
    ///           Defaults to `nil`, which will result in a random seed being created and used.
    /// - Returns: A new ten-sided die.
    static func d10(initialValue: Int = Die.defaultStartingValue, seed: Seed) -> Die {
        .init(sides: 10, initialValue: initialValue, seed: seed)
    }

    // MARK: d12

    /// Initializes a new twelve-sided die.
    static var d12: Die {
        .init(sides: 12)
    }

    /// Initializes a new twelve-sided die with a given seed.
    /// - Parameters:
    ///   - initialValue: The initial value of the die when it is first created.
    ///   - seed: The random number generation seed to use for the
    ///           Defaults to `nil`, which will result in a random seed being created and used.
    /// - Returns: A new twelve-sided die.
    static func d12(initialValue: Int = Die.defaultStartingValue, seed: Seed) -> Die {
        .init(sides: 12, initialValue: initialValue, seed: seed)
    }

    // MARK: d20

    /// Initializes a new twenty-sided die.
    static var d20: Die {
        .init(sides: 20)
    }

    /// Initializes a new twenty-sided die with a given seed.
    /// - Parameters:
    ///   - initialValue: The initial value of the die when it is first created.
    ///   - seed: The random number generation seed to use for the
    ///           Defaults to `nil`, which will result in a random seed being created and used.
    /// - Returns: A new twenty-sided die.
    static func d20(initialValue: Int = Die.defaultStartingValue, seed: Seed? = nil) -> Die {
        .init(sides: 20, initialValue: initialValue, seed: seed)
    }

    // MARK: d100

    /// Initializes a new hundred-sided die .
    static var d100: Die {
        .init(sides: 100)
    }

    /// Initializes a new hundred-sided die with a given seed.
    /// - Parameters:
    ///   - initialValue: The initial value of the die when it is first created.
    ///   - seed: The random number generation seed to use for the
    ///           Defaults to `nil`, which will result in a random seed being created and used.
    /// - Returns: A new hundred-sided die.
    static func d100(initialValue: Int = Die.defaultStartingValue, seed: Seed? = nil) -> Die {
        .init(sides: 100, initialValue: initialValue, seed: seed)
    }
}

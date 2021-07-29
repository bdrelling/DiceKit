// Copyright © 2021 Brian Drelling. All rights reserved.

public typealias DiceHand = [Die]

public extension DiceHand {
    @discardableResult
    func roll() -> [Int] {
        self.map { $0.roll() }
    }
}

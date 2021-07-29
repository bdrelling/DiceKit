// Copyright © 2021 Brian Drelling. All rights reserved.

public extension HandEvaluator where Element == Int {
    func evaluate(_ dice: [Die]) -> [Result] {
        let values = dice.map(\.latestValue)
        return self.evaluate(values)
    }
}

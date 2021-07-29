// Copyright © 2021 Brian Drelling. All rights reserved.

import GameplayKit

final class SeededGenerator: RandomNumberGenerator {
    private let source: GKMersenneTwisterRandomSource

    var seed: UInt64 {
        self.source.seed
    }

    init(seed: Seed? = nil) {
        if let seed = seed {
            self.source = .init(seed: seed.seedValue)
        } else {
            self.source = .init()
        }
    }

    func next() -> UInt64 {
        // GKRandom produces values in [INT32_MIN, INT32_MAX] range; hence we need two numbers to produce 64-bit value.
        let next1 = UInt64(bitPattern: Int64(self.source.nextInt()))
        let next2 = UInt64(bitPattern: Int64(self.source.nextInt()))
        return next1 ^ (next2 << 32)
    }
}

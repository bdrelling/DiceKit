// Copyright © 2021 Brian Drelling. All rights reserved.

public protocol Seed {
    var seedValue: UInt64 { get }
}

extension Int: Seed {
    public var seedValue: UInt64 {
        UInt64(self)
    }
}

extension UInt64: Seed {
    public var seedValue: UInt64 {
        self
    }
}

extension String: Seed {
    public var seedValue: UInt64 {
        UInt64(abs(self.hash))
    }
}

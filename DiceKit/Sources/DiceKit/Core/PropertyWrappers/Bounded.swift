// Copyright © 2021 Brian Drelling. All rights reserved.

@propertyWrapper
public struct Bounded {
    public var wrappedValue: Int {
        didSet {
            if let min = self.minimumValue {
                self.wrappedValue = max(self.wrappedValue, min)
            }

            if let max = self.maximumValue {
                self.wrappedValue = min(self.wrappedValue, max)
            }
        }
    }

    private let minimumValue: Int?
    private let maximumValue: Int?

    init(min minimumValue: Int) {
        self.minimumValue = minimumValue
        self.maximumValue = nil

        // Set the wrapped value to 0 or the minimum value (if it is positive).
        self.wrappedValue = max(0, minimumValue)
    }

    init(max maximumValue: Int) {
        self.minimumValue = nil
        self.maximumValue = maximumValue

        // Set the wrapped value to 0 as there is no minimum.
        self.wrappedValue = 0
    }

    init(min minimumValue: Int, max maximumValue: Int) {
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue

        // Set the wrapped value to 0 or the minimum value (if it is positive).
        self.wrappedValue = max(0, minimumValue)
    }

    init(_ range: Range<Int>) {
        self.init(min: range.lowerBound, max: range.upperBound)
    }

    init(_ range: ClosedRange<Int>) {
        self.init(min: range.lowerBound, max: range.upperBound)
    }

    init(_ range: PartialRangeFrom<Int>) {
        self.init(min: range.lowerBound)
    }

    init(_ range: PartialRangeThrough<Int>) {
        self.init(max: range.upperBound)
    }

    init(_ range: PartialRangeUpTo<Int>) {
        self.init(max: range.upperBound)
    }
}

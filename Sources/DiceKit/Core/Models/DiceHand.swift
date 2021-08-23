// Copyright © 2021 Brian Drelling. All rights reserved.

public typealias DiceHand = [Die]

// MARK: - Extensions

// MARK: Rolling

public extension DiceHand {
    /// The minimum value of a roll.
    var minimumValue: Int {
        self.map(\.minimumValue).reduce(0, +)
    }
    
    /// The maximum value of a roll.
    var maximumValue: Int {
        self.map(\.maximumValue).reduce(0, +)
    }
    
    /// The average value of a roll.
    var averageValue: Float {
        self.map(\.averageValue).reduce(0, +)
    }
    
    var totalPossibleOutcomes: Int {
        self.map(\.maximumValue).reduce(1, *)
    }
    
    @discardableResult
    func roll() -> [Int] {
        self.map { $0.roll() }
    }
    
    func combinations() -> [[Int]] {
        let values = self.enumerated()
            .map { die in
                // Create an array of all possible values for this die.
                [Int](die.element.minimumValue ... die.element.maximumValue)
                    // Map the array to include a unique identifier for the die, to ensure uniqueness later on.
                    .map { (id: die.offset, value: $0) }
            }
            // Flatten the array into single values.
            .flatMap { $0 }
        
        var uniqueCombinations: [[Int]] = []
        
        for combo in values.combinations(ofCount: 2) {
            let diceIDs = combo.map { $0.id }
            
            // Ensure that each die ID appears only once in this combination,
            // otherwise continue without appending.
            guard diceIDs.count == Set(diceIDs).count else {
                continue
            }
            
            uniqueCombinations.append(combo.map { $0.value })
        }
        
        return uniqueCombinations
    }
}

// MARK: Probability

extension Sequence where Element: AdditiveArithmetic {
    /// Returns the total sum of all elements in the sequence
    func sum() -> Element { reduce(.zero, +) }
}

extension Collection where Element: BinaryInteger {
    /// Returns the average of all elements in the array
    func average() -> Element { isEmpty ? .zero : sum() / Element(count) }
    /// Returns the average of all elements in the array as Floating Point type
    func average<T: FloatingPoint>() -> T { isEmpty ? .zero : T(sum()) / T(count) }
}

extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the array
    func average() -> Element { isEmpty ? .zero : sum() / Element(count) }
}

import Algorithms

extension DiceHand: ProbabilityCalculating {
    /// The probability of rolling any specific combination of values.
    /// This value is always equal to 1 divided by the number of sides across all dice.
    public var singleRollProbability: Float {
        Float(self.minimumValue) / Float(self.maximumValue)
    }
    
    public func occurrenceProbability(of condition: ProbabilityCondition) -> Float {
        self.map { $0.occurrenceProbability(of: condition) }.average()
    }
    
    public func scoreProbability(of condition: ProbabilityCondition) -> Float {
        let combinations = self.combinations()
        let totals = combinations.map { $0.reduce(0, +) }
        
        let occurrences: Int
        
        switch condition {
        case let .equalTo(value):
            occurrences = totals.filter { $0 == value }.count
        case let .greaterThan(value):
            occurrences = totals.filter { $0 > value }.count
        case let .greaterThanOrEqualTo(value):
            occurrences = totals.filter { $0 >= value }.count
        case let .lessThan(value):
            occurrences = totals.filter { $0 < value }.count
        case let .lessThanOrEqualTo(value):
            occurrences = totals.filter { $0 <= value }.count
        }
        
        return Float(occurrences) / Float(self.totalPossibleOutcomes)
    }
}

class Solution {
    static func combinationSum2(candidates: [Int], _ target: Int) -> [[Int]] {
        var candidates = candidates
        candidates.sort()

        var visited = Set<String>()
        var ans: [[Int]] = []
        var sln = [Int]()
        helper(0, target: target, sln: &sln, ans: &ans, visited: &visited, candidates: candidates)
        return ans
    }

    static func helper(_ start: Int, target: Int, sln: inout [Int], ans: inout [[Int]], visited: inout Set<String>, candidates: [Int]) {
        if target == 0 {
            if !visited.contains(sln.description) {
                visited.insert(sln.description)
                ans.append(sln)
            }
            return
        }
        for i in start ..< candidates.count {
            if candidates[i] <= target {
                sln.append(candidates[i])
                helper(i+1, target: target - candidates[i], sln: &sln, ans: &ans, visited: &visited, candidates: candidates)
                sln.removeLast()
            }
        }
    }
}

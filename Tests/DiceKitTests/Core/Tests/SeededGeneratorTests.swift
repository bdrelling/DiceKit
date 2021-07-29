// Copyright © 2021 Brian Drelling. All rights reserved.

@testable import DiceKit
import XCTest

final class SeededGeneratorTests: XCTestCase {
    // MARK: No Seeding

    // This isn't a great test since both generators could technically produce the same five results.
    func testNonSeededGeneratorsProduceDifferentResults() {
        // GIVEN: We have two different non-seeded generators.
        var firstGenerator = SeededGenerator()
        var secondGenerator = SeededGenerator()

        // WHEN: We request 5 results from each generator.
        let firstResults: [UInt] = [
            firstGenerator.next(upperBound: 1000),
            firstGenerator.next(upperBound: 1000),
            firstGenerator.next(upperBound: 1000),
            firstGenerator.next(upperBound: 1000),
            firstGenerator.next(upperBound: 1000),
        ]

        let secondResults: [UInt] = [
            secondGenerator.next(upperBound: 1000),
            secondGenerator.next(upperBound: 1000),
            secondGenerator.next(upperBound: 1000),
            secondGenerator.next(upperBound: 1000),
            secondGenerator.next(upperBound: 1000),
        ]

        // THEN: We expect the generators to have different seed values.
        XCTAssertNotEqual(firstGenerator.seed, secondGenerator.seed)

        // THEN: We expect a different set of results from each generator.
        XCTAssertNotEqual(firstResults, secondResults)
    }

    // MARK: Integer Seeding

    func testSeededGeneratorProducesConsistentNonBoundedResults() {
        // GIVEN: We have a generator seeded with an Integer value.
        var generator = SeededGenerator(seed: 420)

        // WHEN: We request 10 results.
        let actualResults: [UInt] = [
            generator.next(),
            generator.next(),
            generator.next(),
            generator.next(),
            generator.next(),
            generator.next(),
            generator.next(),
            generator.next(),
            generator.next(),
            generator.next(),
        ]

        let expectedResults: [UInt] = [
            10706200297351022330,
            11300214306392258842,
            1119346153223345987,
            16803985211966506394,
            5023909402403887752,
            14416101189771128618,
            10864060110203764353,
            17840261050797018065,
            15081759607870709274,
            8811516694380145768,
        ]

        // THEN: We expect the same 10 results each time.
        XCTAssertEqual(actualResults, expectedResults)
    }

    func testSeededGeneratorProducesConsistentBoundedResults() {
        // GIVEN: We have a generator seeded with an Integer value.
        var generator = SeededGenerator(seed: 420)

        // WHEN: We request 10 results.
        let actualResults: [UInt] = [
            generator.next(upperBound: 1000),
            generator.next(upperBound: 1000),
            generator.next(upperBound: 1000),
            generator.next(upperBound: 1000),
            generator.next(upperBound: 1000),
            generator.next(upperBound: 1000),
            generator.next(upperBound: 1000),
            generator.next(upperBound: 1000),
            generator.next(upperBound: 1000),
            generator.next(upperBound: 1000),
        ]

        let expectedResults: [UInt] = [
            580,
            612,
            60,
            910,
            272,
            781,
            588,
            967,
            817,
            477,
        ]

        // THEN: We expect the same 10 results each time.
        XCTAssertEqual(actualResults, expectedResults)
    }

    // MARK: String Seeding

    func testStringSeededGeneratorProducesConsistentSeed() {
        // WHEN: We create a generator seeded with an String value.
        let generator = SeededGenerator(seed: "DiceGame")

        // THEN: We expect a consistent seed value.
        XCTAssertEqual(generator.seed, 7379559652864617737)
    }

    // MARK: Usage

    func testUsingGeneratorToFetchRandomIntegerProducesConsistentResult() {
        // GIVEN: We have a generator seeded with an Integer value.
        var generator = SeededGenerator(seed: 420)

        // WHEN: We request a random number between 1 and 20.
        let result = Int.random(in: 1 ... 20, using: &generator)

        // THEN: We expect a consistent value.
        XCTAssertEqual(result, 12)
    }
}

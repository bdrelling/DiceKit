// Copyright © 2021 Brian Drelling. All rights reserved.

import XCTest

extension XCTestCase {
    func assertEqualIgnoringOrder<T>(_ lhs: [T], _ rhs: [T]) where T: Hashable {
        let difference = Set(lhs).symmetricDifference(Set(rhs))
        self.assertEmpty(difference)
    }

    func assertEmpty<T>(_ collection: T) where T: Collection {
        XCTAssertTrue(collection.isEmpty, "Array should be empty, but instead contains values: \(collection)")
    }
}

// Example of XCTIssue!
//    func assertSomething(about data: Data, file: StaticString = #filePath, line: UInt = #line) {
//        guard !collection.isEmpty else {
//            return
//        }
//
//        // Create issue, declare with var for mutability.
//        var issue = XCTIssue(type: .assertionFailure, compactDescription: "Collection should be empty, but contains values: \(collection)")
//
//        // Capture the call site location as the point of failure.
//        let location = XCTSourceCodeLocation(filePath: file, lineNumber: line)
//        issue.sourceCodeContext = XCTSourceCodeContext(location: location)
//
//        // Attach the invalid data.
//        // issue.add(XCTAttachment(data: data))
//
//        // Record the issue.
//        self.record(issue)
//    }

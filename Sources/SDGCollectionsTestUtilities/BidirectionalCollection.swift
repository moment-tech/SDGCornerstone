/*
 BidirectionalCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to BidirectionalCollection.
@_inlineable public func testBidirectionalCollectionConformance<T>(of collection: T, file: StaticString = #file, line: UInt = #line) where T : BidirectionalCollection {

    testCollectionConformance(of: collection, file: file, line: line)

    let second = collection.index(after: collection.startIndex)
    test(method: (T.index(before: ), "index(before: "), of: collection, with: second, returns: collection.startIndex, file: file, line: line)
}
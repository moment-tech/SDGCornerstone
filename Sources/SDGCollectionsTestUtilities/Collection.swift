/*
 Collection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to Collection.
@_inlineable public func testCollectionConformance<T>(of collection: T, file: StaticString = #file, line: UInt = #line) where T : Collection {
    _ = collection.startIndex
    _ = collection.endIndex
    _ = collection[collection.startIndex]
    _ = collection.index(after: collection.startIndex)
}
/*
 PatternMatch.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The result of a pattern search.
public struct PatternMatch<Searched: SearchableCollection> {

  // MARK: - Initialization

  /// Creates a description of a match.
  ///
  /// - Parameters:
  ///     - range: The range of the match.
  ///     - collection: The collection containing the match.
  @inlinable public init<R>(range: R, in collection: Searched)
  where R: RangeExpression, R.Bound == Searched.Index {
    self.range = range.relative(to: collection)
    self.contents = collection[range]
  }

  // MARK: - Properties

  /// The range.
  public let range: Range<Searched.Index>
  /// The contents of the match.
  public let contents: Searched.SubSequence

  // MARK: - Conversions

  /// Returns the same match in another collection whose indices are shared with the collection originally searched; this is intended for converting a match found in a subsequence into a match in the base collection or vice versa.
  ///
  /// - Requires: The range is valid for the target collection and points to the same elements.
  ///
  /// - Parameters:
  ///     - otherCollection: The other collection.
  @inlinable public func `in`<C>(_ otherCollection: C) -> PatternMatch<C>
  where C: SearchableCollection, C.Index == Searched.Index {
    return PatternMatch<C>(range: range, in: otherCollection)
  }
}

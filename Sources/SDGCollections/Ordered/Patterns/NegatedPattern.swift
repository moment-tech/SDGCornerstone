/*
 NegatedPattern.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A pattern that matches if the underlying pattern does not.
public struct NegatedPattern<Base>: CustomStringConvertible, Pattern, TextualPlaygroundDisplay
where Base: Pattern {

  // MARK: - Initialization

  // @documentation(SDGCornerstone.Not.init(_:))
  /// Creates a negated pattern from another pattern.
  ///
  /// - Parameters:
  ///     - pattern: The underlying pattern to negate.
  @inlinable public init(_ pattern: Base) {
    self.base = pattern
  }

  // MARK: - Properties

  @usableFromInline internal var base: Base

  // MARK: - Pattern

  public typealias Element = Base.Element

  @inlinable public func matches<C: SearchableCollection>(in collection: C, at location: C.Index)
    -> [Range<C.Index>] where C.Element == Element
  {

    if base.primaryMatch(in: collection, at: location) == nil {
      return [(location...location).relative(to: collection)]
    } else {
      return []
    }
  }

  @inlinable public func primaryMatch<C: SearchableCollection>(
    in collection: C,
    at location: C.Index
  ) -> Range<C.Index>? where C.Element == Element {

    if base.primaryMatch(in: collection, at: location) == nil {
      return (location...location).relative(to: collection)
    } else {
      return nil
    }
  }

  @inlinable public func reversed() -> NegatedPattern<Base.Reversed> {
    return NegatedPattern<Base.Reversed>(base.reversed())
  }

  // MARK: - CustomStringConvertible

  public var description: String {
    return "¬(" + String(describing: base) + ")"
  }
}

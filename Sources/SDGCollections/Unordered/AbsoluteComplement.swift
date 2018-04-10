/*
 AbsoluteComplement.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An absolute complement of a set.
public struct AbsoluteComplement<Base : SetDefinition> : SetDefinition {

    // MARK: - Initialization

    /// Creates an absolute complement from a set.
    ///
    /// - Parameters:
    ///     - set: A set.
    @_inlineable public init(_ base: Base) {
        self.base = base
    }

    // MARK: - Properties

    @_versioned internal let base: Base

    // MARK: - SetDefinition

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.Element_]
    /// The element type.
    public typealias Element = Base.Element

    // [_Inherit Documentation: SDGCornerstone.SetDefinition.∋_]
    /// Returns `true` if `precedingValue` contains `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The set.
    ///     - followingValue: The element to test.
    @_inlineable public static func ∋ (precedingValue: AbsoluteComplement, followingValue: Base.Element) -> Bool {
        return precedingValue.base ∌ followingValue
    }
}
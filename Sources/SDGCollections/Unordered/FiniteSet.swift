/*
 FiniteSet.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A set small enough to reasonably iterate over.
///
/// Conformance Requirements:
///
/// - `SetDefinition`
/// - `Collection`
/// - `Element == Element`
public protocol FiniteSet : Collection, ComparableSet {

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊆_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊆_]
    /// Returns `true` if `precedingValue` is a subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    static func ⊆ <S : SetDefinition>(precedingValue: Self, followingValue: S) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊈_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊈_]
    /// Returns `true` if `precedingValue` is not a subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    static func ⊈ <S : SetDefinition>(precedingValue: Self, followingValue: S) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊇_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊇_]
    /// Returns `true` if `precedingValue` is a superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    static func ⊇ <S : SetDefinition>(precedingValue: S, followingValue: Self) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊉_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊉_]
    /// Returns `true` if `precedingValue` is not a superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    static func ⊉ <S : SetDefinition>(precedingValue: S, followingValue: Self) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊊_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊊_]
    /// Returns `true` if `precedingValue` is a strict subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    static func ⊊ <S : FiniteSet>(precedingValue: Self, followingValue: S) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.⊋_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.⊋_]
    /// Returns `true` if `precedingValue` is a strict superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    static func ⊋ <S : FiniteSet>(precedingValue: S, followingValue: Self) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.==_]
    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    static func == <S : FiniteSet>(precedingValue: Self, followingValue: S) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.≠_]
    // [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
    /// Returns `true` if the two values are inequal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    static func ≠ <S : FiniteSet>(precedingValue: Self, followingValue: S) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.overlaps(_:)_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.overlaps(_:)_]
    /// Returns `true` if the sets overlap.
    ///
    /// - Parameters:
    ///     - other: The other set.
    func overlaps<S : SetDefinition>(_ other: S) -> Bool where S.Element == Self.Element

    // [_Define Documentation: SDGCornerstone.FiniteSet.isDisjoint(with:)_]
    // [_Inherit Documentation: SDGCornerstone.ComparableSet.isDisjoint(with:)_]
    /// Returns `true` if the sets are disjoint.
    ///
    /// - Parameters:
    ///     - other: Another set.
    func isDisjoint<S : FiniteSet>(with other: S) -> Bool where S.Element == Self.Element
}

extension FiniteSet {

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊆_]
    /// Returns `true` if `precedingValue` is a subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊆ <S : SetDefinition>(precedingValue: Self, followingValue: S) -> Bool where S.Element == Self.Element {
        for element in precedingValue where element ∉ followingValue {
            return false
        }
        return true
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊈_]
    /// Returns `true` if `precedingValue` is not a subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊈ <S : SetDefinition>(precedingValue: Self, followingValue: S) -> Bool where S.Element == Self.Element {
        return ¬(precedingValue ⊆ followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊇_]
    /// Returns `true` if `precedingValue` is a superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊇ <S : SetDefinition>(precedingValue: S, followingValue: Self) -> Bool where S.Element == Self.Element {
        return followingValue ⊆ precedingValue
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊉_]
    /// Returns `true` if `precedingValue` is not a superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊉ <S : SetDefinition>(precedingValue: S, followingValue: Self) -> Bool where S.Element == Self.Element {
        return ¬(precedingValue ⊇ followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊊_]
    /// Returns `true` if `precedingValue` is a strict subset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible subset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊊ <S : FiniteSet>(precedingValue: Self, followingValue: S) -> Bool where S.Element == Self.Element {
        return precedingValue ⊆ followingValue ∧ precedingValue ⊉ followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.⊋_]
    /// Returns `true` if `precedingValue` is a strict superset of `followingValue`.
    ///
    /// - Parameters:
    ///     - precedingValue: The possible superset to test.
    ///     - followingValue: The other set.
    @_inlineable public static func ⊋ <S : FiniteSet>(precedingValue: S, followingValue: Self) -> Bool where S.Element == Self.Element {
        return precedingValue ⊇ followingValue ∧ precedingValue ⊈ followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @_inlineable public static func == <S : FiniteSet>(precedingValue: Self, followingValue: S) -> Bool where S.Element == Self.Element {
        return precedingValue ⊇ followingValue ∧ precedingValue ⊆ followingValue
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.≠_]
    /// Returns `true` if the two values are inequal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @_inlineable public static func ≠ <S : FiniteSet>(precedingValue: Self, followingValue: S) -> Bool where S.Element == Self.Element {
        return ¬(precedingValue == followingValue)
    }

    // [_Inherit Documentation: SDGCornerstone.ComparableSet.overlaps(_:)_]
    /// Returns `true` if the sets overlap.
    ///
    /// - Parameters:
    ///     - other: The other set.
    @_inlineable public func overlaps<S : SetDefinition>(_ other: S) -> Bool where S.Element == Self.Element {
        for element in self where element ∈ other {
            return true
        }
        return false
    }

    // [_Inherit Documentation: SDGCornerstone.FiniteSet.isDisjoint(with:)_]
    /// Returns `true` if the sets are disjoint.
    ///
    /// - Parameters:
    ///     - other: Another set.
    @_inlineable public func isDisjoint<S : SetDefinition>(with other: S) -> Bool where S.Element == Self.Element {
        return ¬overlaps(other)
    }
}
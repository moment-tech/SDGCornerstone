/*
 RawRepresentableCalendarComponent.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A calendar component defined by a raw value.
public protocol RawRepresentableCalendarComponent : ConsistentlyOrderedCalendarComponent, ExpressibleByIntegerLiteral {

    // MARK: - Associated Type

    // [_Define Documentation: SDGCornerstone.RawRepresentableCalendarComponent.RawValue_]
    /// The raw value type.
    associatedtype RawValue : IntegralArithmetic

    // [_Define Documentation: SDGCornerstone.RawRepresentableCalendarComponent.init(unsafeRawValue:)_]
    /// Creates an instance with an unchecked raw value.
    ///
    /// - Note: Do not call this initializer directly. Call `init(_:)` instead, because it validates the raw value before passing it to this initializer.
    init(unsafeRawValue: RawValue)

    // [_Define Documentation: SDGCornerstone.RawRepresentableCalendarComponent.validRange_]
    /// The valid range for raw values.
    static var validRange: Range<RawValue>? { get }

    // [_Define Documentation: SDGCornerstone.RawRepresentableCalendarComponent.rawValue_]
    /// The raw value.
    var rawValue: RawValue { get }
}

extension RawRepresentableCalendarComponent {

    // MARK: - Initialization

    /// Creates an instance from a raw value.
    public init(_ value: RawValue) {
        if let range = Self.validRange {
            assert(value ∈ range, UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
                switch localization {
                case .englishCanada:
                    return StrictString("Invalid raw value “\(value)” for \(Self.self).")
                }
            }))
        }
        self.init(unsafeRawValue: value)
    }
}
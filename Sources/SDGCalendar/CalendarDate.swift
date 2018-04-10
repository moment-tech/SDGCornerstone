/*
 CalendarDate.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow

/// A date on a particular calendar.
///
/// The `CalendarDate` structure will remain accurate to its initial definition even if calendar or time zone rules change in the future, such as a change in the Daylight Savings start or end times. (This is in contrast to `Date`, which simply defines itself by a number of seconds since an epoch. If any rules were changed in the future, converting it back to a calendar‐based representation would result in a different date and time.)
///
/// To get the current time, use a static function such as `hebrewNow()` or `gregorianNow()`. Each returns a date representing the current time, but is defined according to a different calendar.
public struct CalendarDate : Comparable, Equatable, OneDimensionalPoint, PointProtocol {

    // MARK: - Static Properties

    internal static let epoch = HebrewDate.epoch

    // MARK: - Static Functions

    /// Returns the current date on the Hebrew calendar.
    public static func hebrewNow() -> CalendarDate {
        return CalendarDate(definition: CalendarDate(Date()).converted(to: HebrewDate.self))
    }

    /// Returns the current date on the Gregorian calendar.
    public static func gregorianNow() -> CalendarDate {
        return CalendarDate(definition: CalendarDate(Date()).converted(to: GregorianDate.self))
    }

    // MARK: - Initialization

    /// Creates an instance with the provided definition.
    public init(definition: DateDefinition) {
        self.definition = definition
    }

    // [_Define Documentation: SDGCornerstone.CalendarDate.init(hebrewYear:month:day:hour:part:)_]
    /// Creates a date using the Hebrew calendar.
    ///
    /// This initializer has two written forms whose effects are the same:
    /// - `init(hebrewYear:month:day:hour:part:)` tends to be more legible when used with variables.
    /// - `init(hebrew:_:_:at:_:)` tends to be more legible when used with literals.
    public init(hebrewYear year: HebrewYear, month: HebrewMonth = .tishrei, day: HebrewDay = 1, hour: HebrewHour = 0, part: HebrewPart = 0) {
        self.init(definition: HebrewDate(year: year, month: month, day: day, hour: hour, part: part))
    }

    // [_Inherit Documentation: SDGCornerstone.CalendarDate.init(hebrewYear:month:day:hour:part:)_]
    /// Creates a date using the Hebrew calendar.
    ///
    /// This initializer has two written forms whose effects are the same:
    /// - `init(hebrewYear:month:day:hour:part:)` tends to be more legible when used with variables.
    /// - `init(hebrew:_:_:at:_:)` tends to be more legible when used with literals.
    public init(hebrew month: HebrewMonth, _ day: HebrewDay, _ year: HebrewYear, at hour: HebrewHour = 0, part: HebrewPart = 0) {
        self.init(hebrewYear: year, month: month, day: day, hour: hour, part: part)
    }

    // [_Define Documentation: SDGCornerstone.CalendarDate.init(gregorianYear:month:day:hour:minute:second:)_]
    /// Creates a date using the Hebrew calendar.
    ///
    /// This initializer has two written forms whose effects are the same:
    /// - `init(gregorianYear:month:day:hour:minute:second:)` tends to be more legible when used with variables.
    /// - `init(gregorian:_:_:at:_:_:)` tends to be more legible when used with literals.
    public init(gregorianYear year: GregorianYear, month: GregorianMonth = .january, day: GregorianDay = 1, hour: GregorianHour = 0, minute: GregorianMinute = 0, second: GregorianSecond = 0) {
        let definition = GregorianDate(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        self.init(definition: definition)
    }

    // [_Inherit Documentation: SDGCornerstone.CalendarDate.init(gregorianYear:month:day:hour:minute:second:)_]
    /// Creates a date using the Hebrew calendar.
    ///
    /// This initializer has two written forms whose effects are the same:
    /// - `init(gregorianYear:month:day:hour:minute:second:)` tends to be more legible when used with variables.
    /// - `init(gregorian:_:_:at:_:_:)` tends to be more legible when used with literals.
    public init(gregorian month: GregorianMonth, _ day: GregorianDay, _ year: GregorianYear, at hour: GregorianHour = 0, _ minute: GregorianMinute = 0, _ second: GregorianSecond = 0) {
        self.init(gregorianYear: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }

    /// Creates a calendar date using an instance of `Date`.
    public init(_ date: Date) {
        self.init(definition: FoundationDate(date))
    }

    // MARK: - Properties

    private var definition: DateDefinition {
        willSet {
            cache = Cache()
        }
        didSet {
            cache.conversions[ObjectIdentifier(type(of: definition))] = definition
        }
    }

    private class Cache {
        fileprivate init() {}
        fileprivate var conversions: [ObjectIdentifier: DateDefinition] = [:]
    }
    private var cache = Cache()

    // Hebrew

    /// The Hebrew year.
    public var hebrewYear: HebrewYear {
        return converted(to: HebrewDate.self).year
    }
    /// The Hebrew month.
    public var hebrewMonth: HebrewMonth {
        return converted(to: HebrewDate.self).month
    }
    /// The Hebrew weekday.
    public var hebrewWeekday: HebrewWeekday {
        return converted(to: HebrewWeekdayDate.self).weekday
    }
    /// The Hebrew day.
    public var hebrewDay: HebrewDay {
        return converted(to: HebrewDate.self).day
    }
    /// The Hebrew hour.
    public var hebrewHour: HebrewHour {
        return converted(to: HebrewDate.self).hour
    }
    /// The Hebrew part.
    public var hebrewPart: HebrewPart {
        return converted(to: HebrewDate.self).part
    }

    // Gregorian

    /// The Gregorian year.
    public var gregorianYear: GregorianYear {
        return converted(to: GregorianDate.self).year
    }
    /// The Gregorian month.
    public var gregorianMonth: GregorianMonth {
        return converted(to: GregorianDate.self).month
    }
    /// The Gregorian weekday.
    public var gregorianWeekday: GregorianWeekday {
        return converted(to: GregorianWeekdayDate.self).weekday
    }
    /// The Gregorian day.
    public var gregorianDay: GregorianDay {
        return converted(to: GregorianDate.self).day
    }
    /// The Gregorian hour.
    public var gregorianHour: GregorianHour {
        return converted(to: GregorianDate.self).hour
    }
    /// The Gregorian minute.
    public var gregorianMinute: GregorianMinute {
        return converted(to: GregorianDate.self).minute
    }
    /// The Gregorian second.
    public var gregorianSecond: GregorianSecond {
        return converted(to: GregorianDate.self).second
    }

    private var intervalSinceEpoch: CalendarInterval<FloatMax> {
        if let hebrew = definition as? HebrewDate {
            return hebrew.intervalSinceReferenceDate
        } else {
            return type(of: definition).referenceDate.intervalSinceEpoch + definition.intervalSinceReferenceDate
        }
    }

    // MARK: - Conversions

    private func recomputeDefinition<D : DateDefinition>(as type: D.Type) -> D {
        if type == HebrewDate.self {
            return D(intervalSinceReferenceDate: intervalSinceEpoch)
        } else {
            return D(intervalSinceReferenceDate: intervalSinceEpoch − D.referenceDate.intervalSinceEpoch)
        }
    }

    /// Returns a conversion of the definition to a specific `DateDefinition` type.
    ///
    /// This method is preferred to manual conversions, as the returned conversions are automatically cached.
    ///
    /// - Parameters:
    ///     - type: The type to convert to.
    ///
    /// - Returns: The converted definition.
    public func converted<D : DateDefinition>(to type: D.Type) -> D {

        let cachedDefinition: DateDefinition = cached(in: &cache.conversions[ObjectIdentifier(D.self)]) {
            return recomputeDefinition(as: D.self)
        }

        if let result = cachedDefinition as? D {
            return result
        } else { // [_Exempt from Test Coverage_]
            return recomputeDefinition(as: D.self)
        }
    }

    // MARK: - Text Representations

    /// Returns the date in the ISO format.
    public func dateInISOFormat() -> StrictString {
        var result = gregorianYear.inISOFormat()
        result += "‐"
        result += gregorianMonth.inISOFormat()
        result += "‐"
        result += gregorianDay.inISOFormat()
        return result
    }

    private func dateInBritishEnglish<Y : Year, M : Month, D : Day, W : Weekday>(year: Y, month: M, day: D, weekday: W, withYear: Bool, withWeekday: Bool) -> StrictString {
        var result = day.inEnglishDigits() + " " + month.inEnglish()
        if withYear {
            result += " " + year.inEnglishDigits()
        }
        if withWeekday {
            result.prepend(contentsOf: weekday.inEnglish() + ", ")
        }
        return result
    }

    private func dateInAmericanEnglish<Y : Year, M : Month, D : Day, W : Weekday>(year: Y, month: M, day: D, weekday: W, withYear: Bool, withWeekday: Bool) -> StrictString {
        var result = month.inEnglish() + " " + day.inEnglishDigits()
        if withYear {
            result += ", " + year.inEnglishDigits()
        }
        if withWeekday {
            result.prepend(contentsOf: weekday.inEnglish() + ", ")
        }
        return result
    }

    /// Returns the Hebrew date in British English.
    public func hebrewDateInBritishEnglish(withYear: Bool = true, withWeekday: Bool = false) -> StrictString {
        return dateInBritishEnglish(year: hebrewYear, month: hebrewMonth, day: hebrewDay, weekday: hebrewWeekday, withYear: withYear, withWeekday: withWeekday)
    }

    /// Returns the Hebrew date in American English.
    public func hebrewDateInAmericanEnglish(withYear: Bool = true, withWeekday: Bool = false) -> StrictString {
        return dateInAmericanEnglish(year: hebrewYear, month: hebrewMonth, day: hebrewDay, weekday: hebrewWeekday, withYear: withYear, withWeekday: withWeekday)
    }

    /// Returns the Gregorian date in British English.
    public func gregorianDateInBritishEnglish(withYear: Bool = true, withWeekday: Bool = false) -> StrictString {
        return dateInBritishEnglish(year: gregorianYear, month: gregorianMonth, day: gregorianDay, weekday: gregorianWeekday, withYear: withYear, withWeekday: withWeekday)
    }

    /// Returns the Gregorian date in American English.
    public func gregorianDateInAmericanEnglish(withYear: Bool = true, withWeekday: Bool = false) -> StrictString {
        return dateInAmericanEnglish(year: gregorianYear, month: gregorianMonth, day: gregorianDay, weekday: gregorianWeekday, withYear: withYear, withWeekday: withWeekday)
    }

    /// Returns the time in the ISO format.
    public func timeInISOFormat(includeSeconds: Bool = false) -> StrictString {
        var result = gregorianHour.inISOFormat() + ":" + gregorianMinute.inISOFormat()
        if includeSeconds {
            result += ":" + gregorianSecond.inISOFormat()
        }
        return result
    }

    /// Returns the time in English in the twenty‐four–hour format.
    public func twentyFourHourTimeInEnglish() -> StrictString {
        return gregorianHour.inDigitsInTwentyFourHourFormat() + ":" + gregorianMinute.inDigits()
    }

    /// Returns the time in English in the twelve‐hour format.
    public func twelveHourTimeInEnglish() -> StrictString {
        var result = gregorianHour.inDigitsInTwelveHourFormat() + ":" + gregorianMinute.inDigits()
        result += " " + gregorianHour.amOrPM()
        return result
    }

    // MARK: - iCalendar

    /// Returns a string representation in the floating iCalendar format.
    public func floatingICalendarFormat() -> StrictString {
        var result = gregorianYear.inICalendarFormat()
        result += gregorianMonth.inICalendarFormat()
        result += gregorianDay.inICalendarFormat()
        result += "T"
        result += gregorianHour.inICalendarFormat()
        result += gregorianMinute.inICalendarFormat()
        result += gregorianSecond.inICalendarFormat()
        return result
    }

    /// Returns a string representation in UTC in the iCalendar format.
    public func iCalendarFormat() -> StrictString {
        return floatingICalendarFormat() + "Z"
    }

    // MARK: - Comparable

    // [_Inherit Documentation: SDGCornerstone.Comparable.<_]
    /// Returns `true` if the preceding value is less than the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    public static func < (precedingValue: CalendarDate, followingValue: CalendarDate) -> Bool {
        return precedingValue.intervalSinceEpoch < followingValue.intervalSinceEpoch
    }

    // MARK: - Decodable

    internal static var knownDateDefinitions: [StrictString: DateDefinition.Type] = [
        HebrewDate.identifier: HebrewDate.self,
        GregorianDate.identifier: GregorianDate.self,
        FoundationDate.identifier: FoundationDate.self,
        RelativeDate.identifier: RelativeDate.self
    ]

    /// Registers a definition type so that its instances can be decoded.
    public static func register(_ type: DateDefinition.Type) {
        knownDateDefinitions[type.identifier] = type
    }

    // [_Inherit Documentation: SDGCornerstone.Decodable.init(from:)_]
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let encodingIdentifier = try container.decode(StrictString.self)
        let encodedDefinition = try container.decode(StrictString.self)
        let lastCalculatedInstant = try container.decode(CalendarInterval<FloatMax>.self)

        if let definitionType = CalendarDate.knownDateDefinitions[encodingIdentifier] {
            self.init(definition: try definitionType.init(decoding: encodedDefinition, codingPath: container.codingPath))
        } else {
            self.init(definition: UnknownDate(encodingIdentifier: encodingIdentifier, encodedDefinition: encodedDefinition, lastCalculatedInstant: lastCalculatedInstant))
        }
    }

    // MARK: - Encodable

    // [_Inherit Documentation: SDGCornerstone.Encodable.encode(to:)_]
    /// Encodes this value into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        if let unknown = definition as? UnknownDate {
            try container.encode(unknown.encodingIdentifier)
            try container.encode(unknown.encodedDefinition)
            try container.encode(unknown.lastCalculatedInstant)
        } else {
            let encodedDefinition = try definition.encode()
            try container.encode(type(of: definition).identifier)
            try container.encode(encodedDefinition)
            try container.encode(intervalSinceEpoch)
        }
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    public static func == (precedingValue: CalendarDate, followingValue: CalendarDate) -> Bool {
        return precedingValue.intervalSinceEpoch == followingValue.intervalSinceEpoch
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = CalendarInterval<FloatMax>

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
    /// Moves the preceding point by the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to add.
    public static func += (precedingValue: inout CalendarDate, followingValue: CalendarInterval<FloatMax>) {
        if let relative = precedingValue.definition as? RelativeDate {
            precedingValue.definition = RelativeDate(relative.intervalSince + followingValue, after: relative.baseDate)
        } else {
            precedingValue.definition = RelativeDate(followingValue, after: precedingValue)
        }
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
    /// Returns the vector that leads from the preceding point to the following point.
    ///
    /// - Parameters:
    ///     - precedingValue: The endpoint.
    ///     - followingValue: The startpoint.
    public static func − (precedingValue: CalendarDate, followingValue: CalendarDate) -> CalendarInterval<FloatMax> {
        return precedingValue.intervalSinceEpoch − followingValue.intervalSinceEpoch
    }
}
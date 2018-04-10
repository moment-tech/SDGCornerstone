/*
 Day.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A calendar compenent representing a day of the month.
public protocol Day : ConsistentlyOrderedCalendarComponent
where Vector : IntegerProtocol {

}

extension Day {

    // MARK: - Text Representations

    /// Returns the day in English digits. (“1”, “2”, “3”, etc.)
    @_inlineable public func inEnglishDigits() -> StrictString {
        return ordinal.inDigits()
    }
}
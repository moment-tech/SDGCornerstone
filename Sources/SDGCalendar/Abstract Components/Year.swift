/*
 Year.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText
import SDGLocalization

import SDGCornerstoneLocalizations

/// A calendar compenent representing a year.
public protocol Year: TextualPlaygroundDisplay {

  /// Returns the year in English digits.
  func inEnglishDigits() -> StrictString

  func _inDeutschenZiffern() -> StrictString
  func _enChiffresFrançais() -> StrictString
  func _σεΕλληνικάΨηφία() -> StrictString
  func _בעברית־בספרות() -> StrictString
}

extension Year {

  // MARK: - CustomStringConvertible

  public var description: String {
    return String(
      UserFacing<StrictString, FormatLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          return self.inEnglishDigits()
        case .deutschDeutschland:
          return self._inDeutschenZiffern()
        case .françaisFrance:
          return self._enChiffresFrançais()
        case .ελληνικάΕλλάδα:
          return self._σεΕλληνικάΨηφία()
        case .עברית־ישראל:
          return self._בעברית־בספרות()
        }
      }).resolved()
    )
  }
}

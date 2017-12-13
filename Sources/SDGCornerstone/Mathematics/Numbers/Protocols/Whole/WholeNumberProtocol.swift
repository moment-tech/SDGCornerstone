/*
 WholeNumberProtocol.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type which *only ever* represents whole numbers.
///
/// Conformance Requirements:
///
/// - `WholeArithmetic`
public protocol WholeNumberProtocol : WholeArithmetic {

}

extension WholeNumberProtocol {

    // [_Define Documentation: SDGCornerstone.WholeNumberProtocol.inDigits(thousandsSeparator:)_]
    /// Returns the number in digits.
    ///
    /// - Parameters:
    ///     - thousandsSeparator: The character to use as a thousands separator. (Space by default.)
    public func inDigits(thousandsSeparator: UnicodeScalar = " ") -> StrictString {
        return wholeDigits(thousandsSeparator: thousandsSeparator)
    }

    // [_Define Documentation: SDGCornerstone.WholeNumberProtocol.abbreviatedEnglishOrdinal()_]
    /// Returns the ordinal in its abbreviated English form. (“1st”, “2nd”, “3rd”, etc.)
    public func abbreviatedEnglishOrdinal() -> SemanticMarkup {
        return generateAbbreviatedEnglishOrdinal()
    }

    // [_Define Documentation: SDGCornerstone.WholeNumberProtocol.verkürzteDeutscheOrdnungszahl()_]
    /// Gibt die Ordnungszahl in ihrer verkürtzen deutschen Form zurück. („1.“, „2.“, „3.“, usw.)
    public func verkürzteDeutscheOrdnungszahl() -> StrictString {
        return verkürzteDeutscheOrdnungszahlErzeugen()
    }

    // [_Define Documentation: SDGCornerstone.WholeNumberProtocol.ordinalFrançaisAbrégé(genre:nombre:)_]
    /// Retourne l’ordinal dans sa forme française abrégée. (« 1er », « 2e », « 3e », etc.)
    public func ordinalFrançaisAbrégé(genre: GenreGrammatical, nombre: GrammaticalNumber) -> SemanticMarkup {
        return générerOrdinalFrançaisAbrégé(genre: genre, nombre: nombre)
    }

    // [_Define Documentation: SDGCornerstone.WholeNumberProtocol.συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος:πτώση:αριθμός:)_]
    /// Επιστρέφει την συντομογραφία ελληνικού τακτικού αριθμού.
    public func συντομογραφίαΕλληνικούΤακτικούΑριθμού(γένος: GrammaticalGender, πτώση: ΓραμματικήΠτώση, αριθμός: GrammaticalNumber) -> SemanticMarkup {
        return παραγωγήΣυντομογραφίαςΕλληνικούΤακτικούΑριθμού(γένος: γένος, πτώση: πτώση, αριθμός: αριθμός)
    }

    // [_Define Documentation: SDGCornerstone.WholeNumberProtocol.inRomanNumerals(lowercase:)_]
    /// Returns the number in roman numerals.
    ///
    /// - Precondition: The number must be in the range I–MMMCMXCIX.
    ///
    /// - Parameters:
    ///     - lowercase: Whether the numeral should be in lowercase. (`false` by default.)
    public func inRomanNumerals(lowercase: Bool = false) -> StrictString {
        return romanNumerals(lowercase: lowercase)
    }

    // [_Define Documentation: SDGCornerstone.WholeNumberProtocol.σεΕλληνικούςΑριθμούς(μικράΓράμματα:κεραία:)_]
    /// Επιστρέφει τον αριθμό στους ελληνικούς αριθμούς.
    ///
    /// - Precondition: Ο αριθμός είναι σε Αʹ–͵ΘϠϞΘʹ.
    public func σεΕλληνικούςΑριθμούς(μικράΓράμματα: Bool = false, κεραία: Bool = true) -> StrictString {
        return ελληνικοίΑριθμοί(μικράΓράμματα: μικράΓράμματα, κεραία: κεραία)
    }

    // [_Define Documentation: SDGCornerstone.WholeNumberProtocol.בספרות־עבריות(גרשיים:)_]
    /// מחזירה את המספר בספרות עבריות.
    ///
    /// - Precondition: המספר ב־א׳–ט׳תתקצ״ט.
    public func בספרות־עבריות(גרשיים: Bool = true) -> StrictString {
        return ספרות־עבריות(גרשיים: גרשיים)
    }
}
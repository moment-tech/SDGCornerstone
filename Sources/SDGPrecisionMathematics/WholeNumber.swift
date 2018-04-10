/*
 WholeNumber.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGRandomization
import SDGCornerstoneLocalizations

// [_Example 1: WholeNumber Literals_]
/// An arbitrary‐precision whole number.
///
/// ```swift
/// let million: WholeNumber = 1_000_000
/// let decillion: WholeNumber = "1 000 000 000 000 000 000 000 000 000 000 000"
/// let yobiMultiplier = WholeNumber(binary: "1 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000 0000000000")
/// ```
///
/// `WholeNumber` has a current theoretical limit of about 10 ↑ 178 000 000 000 000 000 000, but since that would occupy over 73 exabytes, in practice `WholeNumber` is limited by the amount of memory available.
public struct WholeNumber : Addable, CodableViaTextConvertibleNumber, Comparable, Equatable, Hashable, PointProtocol, RandomizableNumber, Strideable, Subtractable, TextConvertibleNumber, WholeArithmetic, WholeNumberProtocol {

    // MARK: - Properties

    internal typealias Digit = UIntMax
    internal typealias DigitIndex = Int
    private var unsafeDigits: [Digit] = []
    private var digits: [Digit] {
        get {
            return unsafeDigits
        }
        set {
            unsafeDigits = newValue

            // Normalize

            while unsafeDigits.last == 0 {
                unsafeDigits.removeLast()
            }
        }
    }

    internal var digitIndices: CountableRange<DigitIndex> {
        return digits.indices
    }

    internal subscript(digitIndex: DigitIndex) -> Digit {
        get {
            guard digitIndex < digits.endIndex else {
                return 0
            }

            return digits[digitIndex]
        }
        set {
            var temporaryLeadingZeroes = digits

            let missingDigits = digitIndex + 1 − digits.endIndex
            if missingDigits > 0 {
                temporaryLeadingZeroes.append(contentsOf: [Digit](repeating: 0, count: missingDigits))
            }
            temporaryLeadingZeroes[digitIndex] = newValue

            digits = temporaryLeadingZeroes
        }
    }

    // [_Workaround: Subtypes in extensions have visibility problems. (Swift 4.0.3)_]
    internal typealias BinaryView = WholeNumberBinaryView

    private var binary: BinaryView {
        get {
            return BinaryView(self)
        }
        set {
            self = newValue.wholeNumber
        }
    }

    // MARK: - Addable

    // [_Inherit Documentation: SDGCornerstone.Addable.+=_]
    /// Adds or concatenates the following value to the preceding value, or performs a similar operation implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to add.
    public static func += (precedingValue: inout WholeNumber, followingValue: WholeNumber) {

        var carrying: Digit = 0
        for digitIndex in followingValue.digits.indices {

            var augend = precedingValue[digitIndex]
            let addend = followingValue[digitIndex]

            let carried = carrying
            carrying = 0

            augend.add(addend, carringIn: &carrying)
            augend.add(carried, carringIn: &carrying)

            precedingValue[digitIndex] = augend
        }

        precedingValue[followingValue.digits.endIndex] += carrying
    }

    // MARK: - Comparable

    // [_Inherit Documentation: SDGCornerstone.Comparable.<_]
    /// Returns `true` if the preceding value is less than the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    public static func < (precedingValue: WholeNumber, followingValue: WholeNumber) -> Bool {

        if precedingValue.digits.count ≠ followingValue.digits.count {
            return precedingValue.digits.count < followingValue.digits.count
        }

        for digitIndex in precedingValue.digits.indices.lazy.reversed() {
            let left = precedingValue.digits[digitIndex]
            let right = followingValue.digits[digitIndex]

            if left ≠ right {
                return left < right
            }
        }

        return false // Equal
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    public static func == (precedingValue: WholeNumber, followingValue: WholeNumber) -> Bool {
        return precedingValue.digits.elementsEqual(followingValue.digits)
    }

    // MARK: - Hashable

    // [_Inherit Documentation: SDGCornerstone.Hashable.hashValue_]
    /// The hash value.
    public var hashValue: Int {
        return digits.first?.hashValue ?? 0
    }

    // MARK: - Numeric

    // [_Inherit Documentation: SDGCornerstone.Numeric.init(exactly:)_]
    /// Creates a new instance from the given integer, if it can be represented exactly.
    @_inlineable public init?<T>(exactly source: T) where T : BinaryInteger {
        guard let whole = UIntMax(exactly: source) else {
            return nil // Source could be a negative integer.
        }
        self.init(whole)
    }

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Integer

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.+=_]
    /// Moves the preceding point by the following vector.
    ///
    /// - Parameters:
    ///     - precedingValue: The point to modify.
    ///     - followingValue: The vector to add.
    public static func += (precedingValue: inout WholeNumber, followingValue: Vector) {
        if followingValue.isNegative {
            precedingValue −= followingValue.wholeMagnitude
        } else {
            precedingValue += followingValue.wholeMagnitude
        }
    }

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.−_]
    /// Returns the vector that leads from the preceding point to the following point.
    ///
    /// - Parameters:
    ///     - precedingValue: The endpoint.
    ///     - followingValue: The startpoint.
    public static func − (precedingValue: WholeNumber, followingValue: WholeNumber) -> Vector {
        return Integer(precedingValue) − Integer(followingValue)
    }

    // MARK: - Subtractable

    // [_Inherit Documentation: SDGCornerstone.Subtractable.−=_]
    /// Subtracts the following value from the preceding value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The value to subtract.
    public static func −= (precedingValue: inout WholeNumber, followingValue: WholeNumber) {
        assert(precedingValue ≥ followingValue, UserFacingText({ [precedingValue] (localization: APILocalization) in
            switch localization {
            case .englishCanada: // [_Exempt from Test Coverage_]
                return StrictString("\(precedingValue.inDigits()) − \(followingValue.inDigits()) is impossible for \(WholeNumber.self).")
            }
        }))

        var borrowing: Digit = 0
        for digitIndex in followingValue.digits.indices {

            var minuend = precedingValue[digitIndex]
            let subtrahend = followingValue[digitIndex]

            let borrowed = borrowing
            borrowing = 0

            minuend.subtract(subtrahend, borrowingIn: &borrowing)
            minuend.subtract(borrowed, borrowingIn: &borrowing)

            precedingValue[digitIndex] = minuend
        }

        precedingValue[followingValue.digits.endIndex] −= borrowing
    }

    // MARK: - WholeArithmetic

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(uInt:)_]
    /// Creates an instance equal to `uInt`.
    ///
    /// - Properties:
    ///     - uInt: An instance of `UIntMax`.
    public init(_ uInt: UIntMax) {
        digits = [uInt]
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×_]
    /// Returns the product of the preceding value times the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    public static func × (precedingValue: WholeNumber, followingValue: WholeNumber) -> WholeNumber {

        var product: WholeNumber = 0

        for followingValueIndex in followingValue.digits.indices {
            for precedingValueIndex in precedingValue.digits.indices {

                let precedingValueDigit = precedingValue.digits[precedingValueIndex]
                let followingValueDigit = followingValue.digits[followingValueIndex]

                let digitResult = Digit.multiply(precedingValueDigit, with: followingValueDigit)

                let productIndex = precedingValueIndex + followingValueIndex
                var addend: WholeNumber = 0
                addend[productIndex] = digitResult.product
                addend[productIndex + 1] = digitResult.carried

                product += addend
            }
        }

        return product
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.×=_]
    /// Modifies the preceding value by multiplication with the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: The value to modify.
    ///     - followingValue: The coefficient by which to multiply.
    public static func ×= (precedingValue: inout WholeNumber, followingValue: WholeNumber) {
        precedingValue = precedingValue × followingValue
    }

    internal func quotientAndRemainder(for divisor: WholeNumber) -> (quotient: WholeNumber, remainder: WholeNumber) {

        var quotient: WholeNumber = 0
        var remainingDividend = self

        while remainingDividend ≥ divisor {
            var divides = true // If the following iteration finishes, it is exactly equal and divides precicely once.
            for (dividendBit, divisorBit) in zip(remainingDividend.binary.lastBitsBackwards(maximum: divisor.binary.count), divisor.binary.bitsBackwards()) where dividendBit ≠ divisorBit {
                if dividendBit < divisorBit {
                    divides = false
                    break
                }
                if dividendBit > divisorBit {
                    divides = true
                    break
                }
            }

            var bitPosition = remainingDividend.binary.endIndex − divisor.binary.count
            if ¬divides {
                bitPosition −= 1
            }

            quotient.binary[bitPosition] = true

            var shiftedDivisor = divisor
            shiftedDivisor.binary.shiftLeft(bitPosition − binary.startIndex)
            remainingDividend −= shiftedDivisor
        }

        return (quotient, remainingDividend)
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.divideAccordingToEuclid(by:)_]
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    public mutating func divideAccordingToEuclid(by divisor: WholeNumber) {
        self = quotientAndRemainder(for: divisor).quotient
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.formRemainder(mod:)_]
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    public mutating func formRemainder(mod divisor: WholeNumber) {
        self = quotientAndRemainder(for: divisor).remainder
    }

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<WholeNumber>, fromRandomizer randomizer: Randomizer) {
        let rangeSize: WholeNumber = range.upperBound − range.lowerBound

        var atLimit = true
        var offset: WholeNumber = 0
        for digitIndex in rangeSize.digitIndices.reversed() {
            if atLimit {
                let maximum = rangeSize[digitIndex]
                let digit = Digit(randomInRange: 0 ... maximum, fromRandomizer: randomizer)
                if digit ≠ maximum {
                    atLimit = false
                }
                offset[digitIndex] = digit
            } else {
                offset[digitIndex] = Digit(randomInRange: 0 ... Digit.max, fromRandomizer: randomizer)
            }
        }

        self = range.lowerBound + offset
    }
}
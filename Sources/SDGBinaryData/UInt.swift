/*
 UInt.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension UIntFamily {

    // MARK: - Binary

    /// The value of self represented in binary as a collection of bits.
    @_inlineable public var binary: BinaryView<Self> {
        get {
            return BinaryView(self)
        }
        set {
            self = newValue.uInt
        }
    }
}
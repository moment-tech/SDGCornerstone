/*
 TransparentWrapper.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A wrapper which should be transparent when logging or displaying in a playground.
public protocol TransparentWrapper : CustomDebugStringConvertible, CustomPlaygroundDisplayConvertible, CustomStringConvertible {

    // [_Define Documentation: SDGCornerstone.TransparentWrapper.wrapped_]
    /// The wrapped instance.
    var wrappedInstance: Any { get }
}

extension TransparentWrapper {

    // MARK: - CustomDebugStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomDebugStringConvertible.debugDescription_]
    /// A textual representation of this instance, suitable for debugging.
    @_inlineable public var debugDescription: String {
        return String(reflecting: wrappedInstance)
    }

    // MARK: - CustomPlaygroundDisplayConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomPlaygroundDisplayConvertible.playgroundDescription_]
    /// Returns the custom playground description for this instance.
    @_inlineable public var playgroundDescription: Any {
        return wrappedInstance
    }

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    /// A textual representation of the instance.
    @_inlineable public var description: String {
        return String(describing: wrappedInstance)
    }
}
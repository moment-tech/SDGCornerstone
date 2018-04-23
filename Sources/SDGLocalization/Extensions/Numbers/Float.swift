/*
 Float.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(CoreGraphics)
import CoreGraphics
#endif

extension Double : TextConvertibleNumber {}
#if canImport(CoreGraphics)
// MARK: - #if canImport(CoreGraphics)
extension CGFloat : TextConvertibleNumber {}
#endif
#if !(os(iOS) || os(watchOS) || os(tvOS))
// MARK: - #if !(os(iOS) || os(watchOS) || os(tvOS))
// [_Workaround: Probably available in Swift 4.2 (Swift 4.1)_]
extension Float80 : TextConvertibleNumber {}
#endif
extension Float : TextConvertibleNumber {}
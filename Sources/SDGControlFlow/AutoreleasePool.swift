/*
 AutoreleasePool.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !canImport(ObjectiveC)
  /// Allows code which autoreleases on Darwin to compile on Linux without the need for operating system checks.
  ///
  /// This function does nothing more than execute the provided body on Linux, because Linux has no autoreleasing Objective‐C APIs to link against.
  ///
  /// - Parameters:
  ///     - body: A closure to invoke.
  @inlinable public func autoreleasepool<Result>(invoking body: () throws -> Result) rethrows
    -> Result
  {
    return try body()
  }
#endif

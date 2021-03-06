/*
 FileConvertible.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A type than can be saved to the disk or initialized from a file.
public protocol FileConvertible {

  /// Creates an instance using raw data from a file on the disk.
  ///
  /// - Parameters:
  ///     - file: The data.
  ///     - origin: A URL indicating where the data came from. In some cases this may be helpful in determining how to interpret the data, such as by checking the file extension. This parameter may be `nil` if the data did not come from a file on the disk.
  init(file: Data, origin: URL?) throws

  /// A binary representation that can be written as a file.
  var file: Data { get }
}

extension FileConvertible {

  /// Saves the file to the specified URL.
  ///
  /// - Parameters:
  ///     - url: The URL to save to.
  public func save(to url: URL) throws {
    let directory = url.deletingLastPathComponent()
    try FileManager.default.createDirectory(
      at: directory,
      withIntermediateDirectories: true,
      attributes: nil
    )
    try file.write(to: url, options: [.atomic])
  }

  /// Loads the file at the specified URL.
  ///
  /// - Parameters:
  ///     - url: The URL to read from.
  public init(from url: URL) throws {
    let data: Data
    if let read = try? Data(contentsOf: url, options: [.mappedIfSafe]) {
      data = read
    } else if let read = try? Data(
      contentsOf: URL(fileURLWithPath: url.path.decomposedStringWithCanonicalMapping),
      options: [.mappedIfSafe]
    ) {  // @exempt(from: tests)
      // @exempt(from: tests) Only steps in if the file system has bugs.
      data = read
    } else {
      data = try Data(
        contentsOf: URL(fileURLWithPath: url.path.precomposedStringWithCanonicalMapping),
        options: [.mappedIfSafe]
      )
    }
    try self.init(file: data, origin: url)
  }
}

/*
 UserFacing.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A user‐facing, localized element.
///
/// - SeeAlso: UserFacingDynamic
public struct UserFacing<Element, Localization: SDGLocalization.Localization>: TransparentWrapper {

  // MARK: - Initialization

  /// Creates a user‐facing element from a closure that resolves the element for a specified localization.
  ///
  /// - Parameters:
  ///     - localize: A closure that resolves the element based on a requested localization.
  ///     - localization: The requested localization.
  public init(_ localize: @escaping (_ localization: Localization) -> Element) {
    self.dynamic = UserFacingDynamic<Element, Localization, Void>({ (localization, _) in
      return localize(localization)
    })
  }

  // MARK: - Properties

  /// The same instance typed as `UserFacingDynamic<Element, Localization, Void>`.
  public let dynamic: UserFacingDynamic<Element, Localization, Void>

  // MARK: - Output

  /// Returns the resolved element for the current localization.
  ///
  /// - Parameters:
  ///     - stabilization: The stabilization mode.
  public func resolved(stabilization: LocalizationSetting.StabilizationMode = .none) -> Element {
    return dynamic.resolved(using: (), stabilization: stabilization)
  }

  /// Returns the resolved element for the specified localization.
  ///
  /// - Parameters:
  ///     - localization: The target localization.
  public func resolved(for localization: Localization) -> Element {
    return dynamic.resolved(for: localization, using: ())
  }

  // MARK: - TransparentWrapper

  public var wrappedInstance: Any {
    return resolved()
  }
}

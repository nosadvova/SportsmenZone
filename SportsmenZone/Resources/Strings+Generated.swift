// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum S {
  /// Continue
  internal static let `continue` = S.tr("Localizable", "continue", fallback: "Continue")
  /// Email
  internal static let email = S.tr("Localizable", "email", fallback: "Email")
  /// Finish!
  internal static let finish = S.tr("Localizable", "finish", fallback: "Finish!")
  /// Forgot password?
  internal static let forgotPassword = S.tr("Localizable", "forgot-password", fallback: "Forgot password?")
  /// Full name
  internal static let fullName = S.tr("Localizable", "full-name", fallback: "Full name")
  /// Localizable.strings
  ///   SportsmenZone
  /// 
  ///   Created by Vova Novosad on 23.02.2024.
  internal static let login = S.tr("Localizable", "login", fallback: "Login")
  /// Password
  internal static let password = S.tr("Localizable", "password", fallback: "Password")
  /// Register
  internal static let register = S.tr("Localizable", "register", fallback: "Register")
  /// Registration
  internal static let registration = S.tr("Localizable", "registration", fallback: "Registration")
  /// Repeat password
  internal static let repeatPassword = S.tr("Localizable", "repeat-password", fallback: "Repeat password")
  internal enum Otp {
    /// Enter 4 digit code we'll text you on Email
    internal static let description = S.tr("Localizable", "OTP.description", fallback: "Enter 4 digit code we'll text you on Email")
    /// Didn’t receive anything?
    internal static let didntReceive = S.tr("Localizable", "OTP.didntReceive", fallback: "Didn’t receive anything?")
    /// Resend code
    internal static let resendCode = S.tr("Localizable", "OTP.resendCode", fallback: "Resend code")
    /// Verify your email address
    internal static let title = S.tr("Localizable", "OTP.title", fallback: "Verify your email address")
  }
  internal enum AuthorizationSuccess {
    /// Congratulations, your account has been successfully created!
    internal static let description = S.tr("Localizable", "authorizationSuccess.description", fallback: "Congratulations, your account has been successfully created!")
    /// Registration success
    internal static let title = S.tr("Localizable", "authorizationSuccess.title", fallback: "Registration success")
  }
  internal enum ChooseUser {
    /// Choose your user type based on whether you are a sportsmen or a gym trainer.
    internal static let description = S.tr("Localizable", "chooseUser.description", fallback: "Choose your user type based on whether you are a sportsmen or a gym trainer.")
    /// Sportsmen
    internal static let sportsmen = S.tr("Localizable", "chooseUser.sportsmen", fallback: "Sportsmen")
    /// I'm an athlete!
    internal static let sportsmenDescription = S.tr("Localizable", "chooseUser.sportsmenDescription", fallback: "I'm an athlete!")
    /// Are you a sportsmen or a trainer?
    internal static let title = S.tr("Localizable", "chooseUser.title", fallback: "Are you a sportsmen or a trainer?")
    /// Trainer
    internal static let trainer = S.tr("Localizable", "chooseUser.trainer", fallback: "Trainer")
    /// I'm a coach!
    internal static let trainerDescription = S.tr("Localizable", "chooseUser.trainerDescription", fallback: "I'm a coach!")
  }
  internal enum ForgotPassword {
    /// No worries, we'll send you code for reset.
    internal static let description = S.tr("Localizable", "forgotPassword.description", fallback: "No worries, we'll send you code for reset.")
    /// Reset password
    internal static let resetPassword = S.tr("Localizable", "forgotPassword.reset-password", fallback: "Reset password")
    /// Forgot password?
    internal static let title = S.tr("Localizable", "forgotPassword.title", fallback: "Forgot password?")
  }
  internal enum RegisterPassword {
    /// Those passwords do not match
    internal static let noMatch = S.tr("Localizable", "registerPassword.noMatch", fallback: "Those passwords do not match")
    /// Password must be 6-18 characters(letters, numbers, special characters)
    internal static let notValid = S.tr("Localizable", "registerPassword.notValid", fallback: "Password must be 6-18 characters(letters, numbers, special characters)")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension S {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

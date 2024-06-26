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
  /// Dismiss
  internal static let dismiss = S.tr("Localizable", "dismiss", fallback: "Dismiss")
  /// Email
  internal static let email = S.tr("Localizable", "email", fallback: "Email")
  /// Finish!
  internal static let finish = S.tr("Localizable", "finish", fallback: "Finish!")
  /// First name
  internal static let firstName = S.tr("Localizable", "first-name", fallback: "First name")
  /// Forgot password?
  internal static let forgotPassword = S.tr("Localizable", "forgot-password", fallback: "Forgot password?")
  /// Last name
  internal static let lastName = S.tr("Localizable", "last-name", fallback: "Last name")
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
  /// Save
  internal static let save = S.tr("Localizable", "save", fallback: "Save")
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
  internal enum Gym {
    /// Add gym location:
    internal static let addGymLocation = S.tr("Localizable", "gym.add-gym-location", fallback: "Add gym location:")
    /// All sportsmen
    internal static let allSportsmen = S.tr("Localizable", "gym.all-sportsmen", fallback: "All sportsmen")
    /// Bulding Number
    internal static let buildingNumber = S.tr("Localizable", "gym.buildingNumber", fallback: "Bulding Number")
    /// Choose sport types
    internal static let chooseSportTypes = S.tr("Localizable", "gym.choose-sport-types", fallback: "Choose sport types")
    /// City
    internal static let city = S.tr("Localizable", "gym.city", fallback: "City")
    /// Create new gym
    internal static let createNewGym = S.tr("Localizable", "gym.create-new-gym", fallback: "Create new gym")
    /// Gym description
    internal static let description = S.tr("Localizable", "gym.description", fallback: "Gym description")
    /// District
    internal static let district = S.tr("Localizable", "gym.district", fallback: "District")
    /// Follow
    internal static let followButton = S.tr("Localizable", "gym.followButton", fallback: "Follow")
    /// Do you want to follow the club?
    internal static let followLabel = S.tr("Localizable", "gym.followLabel", fallback: "Do you want to follow the club?")
    /// Gym name
    internal static let name = S.tr("Localizable", "gym.name", fallback: "Gym name")
    /// Street
    internal static let street = S.tr("Localizable", "gym.street", fallback: "Street")
    /// Training day
    internal static let trainingDay = S.tr("Localizable", "gym.training-day", fallback: "Training day")
    /// Trainings
    internal static let trainings = S.tr("Localizable", "gym.trainings", fallback: "Trainings")
    /// Unfollow
    internal static let unfollowButton = S.tr("Localizable", "gym.unfollowButton", fallback: "Unfollow")
    /// Do you want to unfollow the club?
    internal static let unfollowLabel = S.tr("Localizable", "gym.unfollowLabel", fallback: "Do you want to unfollow the club?")
  }
  internal enum Notifications {
    /// Choose notification type
    internal static let chooseNotificationType = S.tr("Localizable", "notifications.choose-notification-type", fallback: "Choose notification type")
    /// Create notification
    internal static let createNotification = S.tr("Localizable", "notifications.create-notification", fallback: "Create notification")
  }
  internal enum RegisterPassword {
    /// Those passwords do not match
    internal static let noMatch = S.tr("Localizable", "registerPassword.noMatch", fallback: "Those passwords do not match")
    /// Password must be 6-18 characters(letters, numbers, special characters)
    internal static let notValid = S.tr("Localizable", "registerPassword.notValid", fallback: "Password must be 6-18 characters(letters, numbers, special characters)")
  }
  internal enum Search {
    /// Search gym
    internal static let searchGym = S.tr("Localizable", "search.searchGym", fallback: "Search gym")
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

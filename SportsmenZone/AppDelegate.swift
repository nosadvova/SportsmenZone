//
//  AppDelegate.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.04.2024.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        ServiceFacade.initializeContainer()
//        FirebaseApp.configure()
        
        return true
    }
}

//extension AppDelegate: UNUserNotificationCenterDelegate {
//    func userNotificationCenter(
//      _ center: UNUserNotificationCenter,
//      willPresent notification: UNNotification
//    ) async -> UNNotificationPresentationOptions {
//      let userInfo = notification.request.content.userInfo
//      Messaging.messaging().appDidReceiveMessage(userInfo)
//
//      return [[.banner, .badge, .sound]]
//    }
//}
//
//extension AppDelegate: MessagingDelegate {
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        guard let fcmToken = fcmToken else { return }
//        // Send the FCM token to the server
//        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
//    }
//}

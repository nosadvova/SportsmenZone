//
//  AppDelegate.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.04.2024.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
      ServiceFacade.initializeContainer()

      return true
    }
}

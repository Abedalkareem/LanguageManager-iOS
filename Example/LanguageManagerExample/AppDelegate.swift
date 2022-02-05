//
//  AppDelegate.swift
//  LanguageManager-iOS
//
//  Created by Abedalkareem on 08/09/2018.
//  Copyright (c) 2018 Abedalkareem. All rights reserved.
//

import LanguageManager_iOS
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // Set the default language for the app
    LanguageManager.shared.defaultLanguage = .deviceLanguage

    return true
  }

}

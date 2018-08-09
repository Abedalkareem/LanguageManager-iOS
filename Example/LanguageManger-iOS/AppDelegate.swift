//
//  AppDelegate.swift
//  LanguageManger-iOS
//
//  Created by Abedalkareem on 08/09/2018.
//  Copyright (c) 2018 Abedalkareem. All rights reserved.
//

import UIKit
import LanguageManger_iOS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Set the default language for the app
        LanguageManger.shared.defaultLanguage = .en

        return true
    }


}


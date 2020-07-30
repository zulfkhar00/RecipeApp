//
//  AppDelegate.swift
//  Recipe
//
//  Created by Zulfkhar Maukey on 24/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var initialVC = sb.instantiateViewController(withIdentifier: "Onboarding")
        
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "onboardingComplete") {
            initialVC = sb.instantiateViewController(withIdentifier: "Mainapp")
        }
        
        window?.rootViewController = initialVC
        window?.makeKeyAndVisible()
        
        return true
    }


}


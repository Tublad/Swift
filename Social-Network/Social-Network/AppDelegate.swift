//
//  AppDelegate.swift
//  Social-Network
//
//  Created by Евгений Шварцкопф on 23/11/2019.
//  Copyright © 2019 Евгений Шварцкопф. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftKeychainWrapper

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let config = Realm.Configuration(schemaVersion: 2)
        Realm.Configuration.defaultConfiguration = config
        
        window = UIWindow(frame: CGRect(x: 0,
                                        y: 0,
                                        width: UIScreen.main.bounds.width,
                                        height: UIScreen.main.bounds.height))
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
    // MARK: сохранения данных в keychain через вспомогательную библиотеку SwiftKeychainWrapper             И осуществил переход на другой экран, но он все равно идет на экран авторизации и делает повторную операцию! Как бы понял смысли, но не уверен насколько верно я понял
    
        
        if let userId = KeychainWrapper.standard.string(forKey: "user") {
            Session.shared.userId = userId
            guard let token = KeychainWrapper.standard.string(forKey: userId) else { return false}
            Session.shared.token = token
            let tabBar = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
            window?.rootViewController = tabBar
            window?.makeKeyAndVisible()
            return true 
        } else {
            let webView = storyboard.instantiateViewController(withIdentifier: "VkWebViewController")
            window?.rootViewController = webView
            window?.makeKeyAndVisible()
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


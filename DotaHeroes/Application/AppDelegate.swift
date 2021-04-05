//
//  AppDelegate.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 01/04/21.
//

import Kingfisher
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController?.navigate(type: .root, module: DHRoute.heroList)

        let navBar = UINavigationBar.appearance()
        navBar.tintColor = Colors.lightBlue
        navBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Colors.darkBlue
        ]
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // do something
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // do something
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // do something
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // do something
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // do something
    }
}

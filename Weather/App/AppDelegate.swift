//
//  AppDelegate.swift
//  Weather
//
//  Created by akashlal on 12/03/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    static func shared() -> AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let mainNavigationVC = UINavigationController()
        window?.rootViewController = mainNavigationVC
        
        let searchVC = SearchVC.loadFromNib()
        mainNavigationVC.setViewControllers([searchVC], animated: true)
        
        return true
    }


}

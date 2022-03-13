//
//  AppDelegate.swift
//  Weather
//
//  Created by akashlal on 12/03/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var coordinator: RootCoordinator?
    var window: UIWindow?
    
    static func shared() -> AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let mainNavigationVC = UINavigationController()
        coordinator = RootCoordinator(navigationController: mainNavigationVC)
        coordinator?.start()
        window?.rootViewController = mainNavigationVC
        
        return true
    }


}

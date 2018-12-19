//
//  AppDelegate.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import UIKit
import CoreData
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private lazy var dependencyContainer = DependencyContainer()
    
    private lazy var mainCoordinator = MainCoordinator(presenter: self.window!,
                                                       sessionManager: self.dependencyContainer.serviceContainer.vkChallengeSessionManager,
                                                       coordinatorFactory: self.dependencyContainer.coordinatorFactory)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.dependencyContainer.serviceContainer.loginService.setup()
        self.mainCoordinator.start()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        VKSdk.processOpen(url, fromApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        return true
    }
}


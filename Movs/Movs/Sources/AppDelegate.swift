//
//  AppDelegate.swift
//  Movs
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // MARK: - Lazy variables

    private lazy var appCoordinator: Coordinator? = {
        guard let window = window else {
            return nil
        }

        return AppCoordinator(rootController: window)
    }()

    // MARK: - UIApplication Lifecycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        appCoordinator?.start()

        return true
    }
}


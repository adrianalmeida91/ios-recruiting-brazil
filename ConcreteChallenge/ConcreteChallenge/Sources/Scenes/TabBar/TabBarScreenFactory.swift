//
//  TabBarScreenFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum TabBarScreenFactory {
    static func makeTabBar() -> UIViewController {
        let tabBarViewController = TabBarViewController()

        return tabBarViewController
    }
}

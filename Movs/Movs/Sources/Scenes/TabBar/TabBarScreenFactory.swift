//
//  TabBarScreenFactory.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum TabBarScreenFactory {
    static func make(viewControllers: [UIViewController], tabBarDelegate: TabBarViewControllerDelegate) -> UIViewController {
        let tabBarViewController = TabBarViewController(tabBarViewControllers: viewControllers, delegate: tabBarDelegate)

        return tabBarViewController
    }
}

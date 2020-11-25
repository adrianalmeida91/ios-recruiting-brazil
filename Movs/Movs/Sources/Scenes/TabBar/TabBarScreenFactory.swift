//
//  TabBarScreenFactory.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum TabBarScreenFactory {
    static func make(tabBarDelegate: TabBarViewControllerDelegate, moviesDelegate: MoviesViewControllerDelegate) -> UIViewController {
        let moviesViewController = MoviesScreenFactory.makeForTabBar(delegate: moviesDelegate)

        let favoritesViwController = FavoritesScreenFactory.makeForTabBar()

        let tabBarViewController = TabBarViewController(tabBarViewControllers: [moviesViewController, favoritesViwController], delegate: tabBarDelegate)

        return tabBarViewController
    }
}

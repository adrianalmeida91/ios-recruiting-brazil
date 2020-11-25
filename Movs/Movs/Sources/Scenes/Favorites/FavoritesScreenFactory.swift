//
//  FavoritesScreenFactory.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum FavoritesScreenFactory {
    static func make() -> UIViewController {
        let provider = MovieRealmDbService()
        let worker = RealmWorker(provider: provider)

        let presenter = FavoritesPresenter()

        let interactor = FavoritesInteractor(worker: worker, presenter: presenter)

        let favoritesViewController = FavoritesViewController(interactor: interactor)
        presenter.viewController = favoritesViewController

        return favoritesViewController
    }

    static func makeForTabBar() -> UIViewController {
        let viewController = make()

        let favoritesTabBarIcon = UITabBarItem()
        favoritesTabBarIcon.image = UIImage(assets: .favoriteEmptyIcon)
        favoritesTabBarIcon.title = Strings.favorites.localizable
        viewController.tabBarItem = favoritesTabBarIcon

        return viewController
    }
}

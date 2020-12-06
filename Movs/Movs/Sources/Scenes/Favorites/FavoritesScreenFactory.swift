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

        let favoritesTabBarItem = UITabBarItem()
        favoritesTabBarItem.image = UIImage(assets: .favoriteEmptyIcon)
        favoritesTabBarItem.title = Strings.favorites.localizable
        favoritesTabBarItem.accessibilityIdentifier = MovsIdentifiers.favoritesTabBarItem.identifier
        viewController.tabBarItem = favoritesTabBarItem

        return viewController
    }
}

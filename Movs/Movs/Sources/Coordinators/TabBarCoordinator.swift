//
//  MoviesCoordinator.swift
//  Movs
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class TabBarCoordinator: Coordinator, TabBarViewControllerDelegate, MoviesViewControllerDelegate, FilterViewControllerDelegate {
    private weak var rootController: AppRootController?

    // MARK: - Initializer

    public init(rootController: AppRootController?) {
        self.rootController = rootController
    }

    // MARK: - Coordinator conforms

    func start() {
        let moviesViewController = MoviesScreenFactory.makeForTabBar(delegate: self)
        let favoritesViwController = FavoritesScreenFactory.makeForTabBar()
        let tabBarViewController = TabBarScreenFactory.make(viewControllers: [moviesViewController, favoritesViwController], tabBarDelegate: self)
        let navigationController = UINavigationController(rootViewController: tabBarViewController)

        rootController?.rootViewController = navigationController
    }

    // MARK: - TabBarViewControllerDelegate conforms

    func filterIconTapped(_ viewController: TabBarViewController) {
        let filterTypeViewController = FilterScreenFactory.make(delegate: self)
        pushViewController(viewController: filterTypeViewController, true)
    }

    func filterSearchTapped(filter: FilterSearch, _ viewController: TabBarViewController) {
        guard let viewController = viewController.selectedViewController as? FilterProtocol else {
            return print(Strings.viewControllerNotFound.localizable)
        }

        viewController.filter(newFilter: filter)
    }

    // MARK: - MoviesViewControllerDelegate conforms

    func galleryItemTapped(movie: Movie, _ viewController: MoviesViewController) {
        let moviesDetailsViewController = MovieDetailsScreenFactory.make(movie: movie)
        pushViewController(viewController: moviesDetailsViewController, true)
    }

    // MARK: - FilterViewControllerDelegate conforms

    func filterApplyButtonTapped(filter: FilterSearch, _ viewController: FilterViewController) {
        guard let viewController = fetchViewController(TabBarViewController.self) else {
            return
        }

        popToViewController(viewController: viewController, true)
        viewController.filter(filter: filter)
    }

    func backButtonTapped(_ viewController: FilterViewController) {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Private functions

    private func pushViewController(viewController: UIViewController, _ animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    private func popViewController() {
        guard let rootController = rootController,
              let rootViewController = rootController.rootViewController,
              let navigationController = rootViewController as? UINavigationController else {
                return
        }

        navigationController.popViewController(animated: true)
    }

    private func popToViewController(viewController: UIViewController, _ animated: Bool) {
        navigationController?.popToViewController(viewController, animated: animated)
    }

    private func fetchViewController<T: UIViewController>(_ type: T.Type)  -> T? {
        let viewController = navigationController?.viewControllers.first { $0 is T }
        if let viewController = viewController as? T {
            return viewController
        }

        return nil
    }

    // MARK: - Private computed variable

    private var navigationController: UINavigationController? {
        guard let rootController = rootController,
              let rootViewController = rootController.rootViewController,
              let navigationController = rootViewController as? UINavigationController else {
                return nil
        }

        return navigationController
    }
}

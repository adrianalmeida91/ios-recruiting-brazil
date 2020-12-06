//
//  TabBarViewControllerDelegateSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 22/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class TabBarViewControllerDelegateSpy: TabBarViewControllerDelegate {
    private(set) var invokedFilterIconTapped = false
    private(set) var invokedFilterIconTappedCount = 0
    private(set) var invokedFilterIconTappedParameters: (viewController: TabBarViewController, Void)?
    private(set) var invokedFilterIconTappedParametersList = [(viewController: TabBarViewController, Void)]()

    private(set) var invokedFilterSearchTapped = false
    private(set) var invokedFilterSearchTappedCount = 0
    private(set) var invokedFilterSearchTappedParameters: (filter: FilterSearch, viewController: TabBarViewController)?
    private(set) var invokedFilterSearchTappedParametersList = [(filter: FilterSearch, viewController: TabBarViewController)]()

    // MARK: - TabBarViewControllerDelegate conforms

    func filterIconTapped(_ viewController: TabBarViewController) {
        invokedFilterIconTapped = true
        invokedFilterIconTappedCount += 1
        invokedFilterIconTappedParameters = (viewController, ())
        invokedFilterIconTappedParametersList.append((viewController, ()))
    }

    func filterSearchTapped(filter: FilterSearch, _ viewController: TabBarViewController) {
        invokedFilterSearchTapped = true
        invokedFilterSearchTappedCount += 1
        invokedFilterSearchTappedParameters = (filter, viewController)
        invokedFilterSearchTappedParametersList.append((filter, viewController))
    }
}

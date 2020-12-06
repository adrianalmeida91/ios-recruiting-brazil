//
//  FilterViewControllerDelegateSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class FilterViewControllerDelegateSpy: FilterViewControllerDelegate {
    private(set) var invokedFilterApplyButtonTapped = false
    private(set) var invokedFilterApplyButtonTappedCount = 0
    private(set) var invokedFilterApplyButtonTappedParameters: (filter: FilterSearch, viewController: FilterViewController)?
    private(set) var invokedFilterApplyButtonTappedParametersList = [(filter: FilterSearch, viewController: FilterViewController)]()

    private(set) var invokedBackButtonTapped = false
    private(set) var invokedBackButtonTappedCount = 0
    private(set) var invokedBackButtonTappedParameters: (viewController: FilterViewController, Void)?
    private(set) var invokedBackButtonTappedParametersList = [(viewController: FilterViewController, Void)]()

    // MARK: - FilterViewControllerDelegate conforms

    func filterApplyButtonTapped(filter: FilterSearch, _ viewController: FilterViewController) {
        invokedFilterApplyButtonTapped = true
        invokedFilterApplyButtonTappedCount += 1
        invokedFilterApplyButtonTappedParameters = (filter, viewController)
        invokedFilterApplyButtonTappedParametersList.append((filter, viewController))
    }

    func backButtonTapped(_ viewController: FilterViewController) {
        invokedBackButtonTapped = true
        invokedBackButtonTappedCount += 1
        invokedBackButtonTappedParameters = (viewController, ())
        invokedBackButtonTappedParametersList.append((viewController, ()))
    }
}

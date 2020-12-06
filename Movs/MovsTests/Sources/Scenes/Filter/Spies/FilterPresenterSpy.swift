//
//  FilterPresenterSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class FilterPresenterSpy: FilterPresentationLogic {
    private(set) var invokedPresentDates = false
    private(set) var invokedPresentDatesCount = 0
    private(set) var invokedPresentDatesParameters: (response: Filter.FetchDates.Response, Void)?
    private(set) var invokedPresentDatesParametersList = [(response: Filter.FetchDates.Response, Void)]()

    private(set) var invokedPresentGenres = false
    private(set) var invokedPresentGenresCount = 0
    private(set) var invokedPresentGenresParameters: (response: Filter.FetchGenres.Response, Void)?
    private(set) var invokedPresentGenresParametersList = [(response: Filter.FetchGenres.Response, Void)]()

    private(set) var invokedPresentFailure = false
    private(set) var invokedPresentFailureCount = 0

    // MARK: - FilterPresentationLogic conforms

    func presentDates(response: Filter.FetchDates.Response) {
        invokedPresentDates = true
        invokedPresentDatesCount += 1
        invokedPresentDatesParameters = (response, ())
        invokedPresentDatesParametersList.append((response, ()))
    }

    func presentGenres(response: Filter.FetchGenres.Response) {
        invokedPresentGenres = true
        invokedPresentGenresCount += 1
        invokedPresentGenresParameters = (response, ())
        invokedPresentGenresParametersList.append((response, ()))
    }

    func presentFailure() {
        invokedPresentFailure = true
        invokedPresentFailureCount += 1
    }
}

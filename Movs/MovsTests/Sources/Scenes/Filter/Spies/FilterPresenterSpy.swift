//
//  FilterPresenterSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class FilterPresenterSpy: FilterPresentationLogic {
    private(set) var invokedOnFetchedDates = false
    private(set) var invokedOnFetchedDatesCount = 0
    private(set) var invokedOnFetchedDatesParameters: (response: Filter.FetchDates.Response, Void)?
    private(set) var invokedOnFetchedDatesParametersList = [(response: Filter.FetchDates.Response, Void)]()

    private(set) var invokedOnFetchedGenres = false
    private(set) var invokedOnFetchedGenresCount = 0
    private(set) var invokedOnFetchedGenresParameters: (response: Filter.FetchGenres.Response, Void)?
    private(set) var invokedOnFetchedGenresParametersList = [(response: Filter.FetchGenres.Response, Void)]()

    private(set) var invokedOnFetchedGenresFailure = false
    private(set) var invokedOnFetchedGenresFailureCount = 0

    // MARK: - FilterPresentationLogic conforms

    func onFetchedDates(response: Filter.FetchDates.Response) {
        invokedOnFetchedDates = true
        invokedOnFetchedDatesCount += 1
        invokedOnFetchedDatesParameters = (response, ())
        invokedOnFetchedDatesParametersList.append((response, ()))
    }

    func onFetchedGenres(response: Filter.FetchGenres.Response) {
        invokedOnFetchedGenres = true
        invokedOnFetchedGenresCount += 1
        invokedOnFetchedGenresParameters = (response, ())
        invokedOnFetchedGenresParametersList.append((response, ()))
    }

    func onFailure() {
        invokedOnFetchedGenresFailure = true
        invokedOnFetchedGenresFailureCount += 1
    }
}

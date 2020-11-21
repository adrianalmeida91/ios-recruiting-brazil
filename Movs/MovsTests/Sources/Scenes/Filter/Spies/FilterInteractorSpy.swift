//
//  FilterInteractorSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class FilterInteractorSpy: FilterBusinessLogic {
    private(set) var invokedFetchDates = false
    private(set) var invokedFetchDatesCount = 0

    private(set) var invokedFetchGenres = false
    private(set) var invokedFetchGenresCount = 0
    private(set) var invokedFetchGenresParameters: (request: Filter.FetchGenres.Request, Void)?
    private(set) var invokedFetchGenresParametersList = [(request: Filter.FetchGenres.Request, Void)]()

    // MARK: - FilterBusinessLogic conforms

    func fetchDates() {
        invokedFetchDates = true
        invokedFetchDatesCount += 1
    }

    func fetchGenres(request: Filter.FetchGenres.Request) {
        invokedFetchGenres = true
        invokedFetchGenresCount += 1
        invokedFetchGenresParameters = (request, ())
        invokedFetchGenresParametersList.append((request, ()))
    }
}

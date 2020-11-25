//
//  FilterDisplaySpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class FilterDisplaySpy: FilterDisplayLogic {
    private(set) var invokedOnFetchedDates = false
    private(set) var invokedOnFetchedDatesCount = 0
    private(set) var invokedOnFetchedDatesParameters: (viewModel: Filter.FetchDates.ViewModel, Void)?
    private(set) var invokedOnFetchedDatesParametersList = [(viewModel: Filter.FetchDates.ViewModel, Void)]()

    private(set) var invokedOnFetchedGenres = false
    private(set) var invokedOnFetchedGenresCount = 0
    private(set) var invokedOnFetchedGenresParameters: (viewModel: Filter.FetchGenres.ViewModel, Void)?
    private(set) var invokedOnFetchedGenresParametersList = [(viewModel: Filter.FetchGenres.ViewModel, Void)]()

    private(set) var invokedDisplayGenericError = false
    private(set) var invokedDisplayGenericErrorCount = 0

    // MARK: - FilterDisplayLogic conforms

    func onFetchedDates(viewModel: Filter.FetchDates.ViewModel) {
        invokedOnFetchedDates = true
        invokedOnFetchedDatesCount += 1
        invokedOnFetchedDatesParameters = (viewModel, ())
        invokedOnFetchedDatesParametersList.append((viewModel, ()))
    }

    func onFetchedGenres(viewModel: Filter.FetchGenres.ViewModel) {
        invokedOnFetchedGenres = true
        invokedOnFetchedGenresCount += 1
        invokedOnFetchedGenresParameters = (viewModel, ())
        invokedOnFetchedGenresParametersList.append((viewModel, ()))
    }

    func displayError() {
        invokedDisplayGenericError = true
        invokedDisplayGenericErrorCount += 1
    }
}

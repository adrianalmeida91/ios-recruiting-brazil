//
//  FilterDisplaySpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class FilterDisplaySpy: FilterDisplayLogic {
    private(set) var invokedDisplayDates = false
    private(set) var invokedDisplayDatesCount = 0
    private(set) var invokedDisplayDatesParameters: (viewModel: Filter.FetchDates.ViewModel, Void)?
    private(set) var invokedDisplayDatesParametersList = [(viewModel: Filter.FetchDates.ViewModel, Void)]()

    private(set) var invokedDisplayGenres = false
    private(set) var invokedDisplayGenresCount = 0
    private(set) var invokedDisplayGenresParameters: (viewModel: Filter.FetchGenres.ViewModel, Void)?
    private(set) var invokedDisplayGenresParametersList = [(viewModel: Filter.FetchGenres.ViewModel, Void)]()

    private(set) var invokedDisplayError = false
    private(set) var invokedDisplayErrorCount = 0

    // MARK: - FilterDisplayLogic

    func displayDates(viewModel: Filter.FetchDates.ViewModel) {
        invokedDisplayDates = true
        invokedDisplayDatesCount += 1
        invokedDisplayDatesParameters = (viewModel, ())
        invokedDisplayDatesParametersList.append((viewModel, ()))
    }

    func displayGenres(viewModel: Filter.FetchGenres.ViewModel) {
        invokedDisplayGenres = true
        invokedDisplayGenresCount += 1
        invokedDisplayGenresParameters = (viewModel, ())
        invokedDisplayGenresParametersList.append((viewModel, ()))
    }

    func displayError() {
        invokedDisplayError = true
        invokedDisplayErrorCount += 1
    }
}

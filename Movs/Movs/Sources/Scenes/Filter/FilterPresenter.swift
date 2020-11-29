//
//  FilterPresenter.swift
//  Movs
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol FilterPresentationLogic: AnyObject {
    func presentDates(response: Filter.FetchDates.Response)
    func presentGenres(response: Filter.FetchGenres.Response)
    func presentFailure()
}

final class FilterPresenter: FilterPresentationLogic {
    weak var viewController: FilterDisplayLogic?

    // MARK: - FilterPresentationLogic conforms

    func presentDates(response: Filter.FetchDates.Response) {
        let viewModel = Filter.FetchDates.ViewModel(dates: response.dates)
        viewController?.displayDates(viewModel: viewModel)
    }

    func presentGenres(response: Filter.FetchGenres.Response) {
        let viewModel = Filter.FetchGenres.ViewModel(genres: response.genres)
        viewController?.displayGenres(viewModel: viewModel)
    }

    func presentFailure() {
        viewController?.displayError()
    }
}

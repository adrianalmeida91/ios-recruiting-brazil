//
//  FilterPresenter.swift
//  Movs
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol FilterPresentationLogic: AnyObject {
    func onFetchedDates(response: Filter.FetchDates.Response)
    func onFetchedGenres(response: Filter.FetchGenres.Response)
    func onFailure()
}

final class FilterPresenter: FilterPresentationLogic {
    weak var viewController: FilterDisplayLogic?

    // MARK: - FilterPresentationLogic conforms

    func onFetchedDates(response: Filter.FetchDates.Response) {
        let viewModel = Filter.FetchDates.ViewModel(dates: response.dates)
        viewController?.displayDates(viewModel: viewModel)
    }

    func onFetchedGenres(response: Filter.FetchGenres.Response) {
        let viewModel = Filter.FetchGenres.ViewModel(genres: response.genres)
        viewController?.displayGenres(viewModel: viewModel)
    }

    func onFailure() {
        viewController?.displayError()
    }
}

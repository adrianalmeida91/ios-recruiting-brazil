//
//  FilterInteractor.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

protocol FilterBusinessLogic: AnyObject {
    func fetchGenres(request: Filter.FetchGenres.Request)
    func fetchDates()
}

final class FilterInteractor: FilterBusinessLogic {
    private let worker: MoyaWorkerProtocol
    private let presenter: FilterPresentationLogic

    // MARK: - Initializers

    init(worker: MoyaWorkerProtocol, presenter: FilterPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }

    // MARK: - FilterBusinessLogic conforms

    func fetchGenres(request: Filter.FetchGenres.Request) {
        worker.fetchGenres(language: request.language) { result in
            switch result {
            case let .success(response):
                let genres = response.genres.map { $0.name }
                self.presenter.onFetchGenresSuccess(response: Filter.FetchGenres.Response(genres: genres))
            case let .failure(error):
                self.onFailure(error: error)
            }
        }
    }

    func fetchDates() {
        let calendar = Calendar.current
        var dates: [String] = []

        for i in 0...220 {
            let currentDate = Date()
            if let yearsBefore = Calendar.current.date(byAdding: .year, value: -i, to: currentDate) {
                dates.append(String(calendar.component(.year, from: yearsBefore)))
            }
        }

        presenter.onFetchDatesSuccessful(dates: dates)
    }

    // MARK: - Private functions

    private func onFailure(error: NetworkError) {
        print(error.errorDescription)
        self.presenter.onFetchGenresFailure()
    }
}

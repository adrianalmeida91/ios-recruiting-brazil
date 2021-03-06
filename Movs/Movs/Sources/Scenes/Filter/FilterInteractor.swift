//
//  FilterInteractor.swift
//  Movs
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

protocol FilterBusinessLogic: AnyObject {
    func fetchDates()
    func fetchGenres(request: Filter.FetchGenres.Request)
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

    func fetchDates() {
        let calendar = Calendar.current
        var dates: [String] = []

        for i in 0...200 {
            let currentDate = Date()
            if let yearsBefore = Calendar.current.date(byAdding: .year, value: -i, to: currentDate) {
                dates.append(String(calendar.component(.year, from: yearsBefore)))
            }
        }

        let response = Filter.FetchDates.Response(dates: dates)
        presenter.presentDates(response: response)
    }

    func fetchGenres(request: Filter.FetchGenres.Request) {
        worker.fetchGenres(language: request.language) { result in
            switch result {
            case let .success(response):
                let genres = response.genres.map { $0.name }
                self.presenter.presentGenres(response: Filter.FetchGenres.Response(genres: genres))
            case let .failure(error):
                print(error.localizedDescription)
                self.presenter.presentFailure()
            }
        }
    }
}

//
//  FavoritesPresenterTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class FavoritesPresenterTests: XCTestCase {
    private lazy var sut: FavoritesPresenter = {
        let presenter = FavoritesPresenter()
        presenter.viewController = displaySpy

        return presenter
    }()

    // MARK: - Private constants

    private let displaySpy = FavoritesDisplaySpy()

    private let search = MocksHelper.Strings.searchError.rawValue

    private let date = [MocksHelper.Strings.dateError.rawValue]

    private let genre = [MocksHelper.Strings.genreError.rawValue]

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplayEmptyView)
        XCTAssertFalse(displaySpy.invokedDisplayMovieUnfavorite)
        XCTAssertFalse(displaySpy.invokedDisplayError)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedMovies)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedError)
    }

    func testPresentFetchedMoviesShouldDisplayMovies() throws {
        let movies = MocksHelper.getMovies()
        let response = Favorites.FetchMovies.Response(movies: movies)
        sut.presentFetchedMovies(response: response)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplayMoviesParameters)

        XCTAssertTrue(displaySpy.invokedDisplayMovies)
        XCTAssertEqual(displaySpy.invokedDisplayMoviesCount, 1)
        XCTAssertEqual(parameters.viewModel.movies, movies)
        XCTAssertEqual(displaySpy.invokedDisplayMoviesParametersList.count, 1)
        
        XCTAssertFalse(displaySpy.invokedDisplayEmptyView)
        XCTAssertFalse(displaySpy.invokedDisplayMovieUnfavorite)
        XCTAssertFalse(displaySpy.invokedDisplayError)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedMovies)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedError)
    }

    func testPresentEmptyViewShouldDisplayEmptyView() {
        sut.presentEmptyView()

        XCTAssertTrue(displaySpy.invokedDisplayEmptyView)
        XCTAssertEqual(displaySpy.invokedDisplayEmptyViewCount, 1)

        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplayMovieUnfavorite)
        XCTAssertFalse(displaySpy.invokedDisplayError)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedMovies)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedError)
    }

    func testPresentMovieUnfavoriteShouldDisplayMovieUnfavorite() {
        sut.presentMovieUnfavorite()

        XCTAssertTrue(displaySpy.invokedDisplayMovieUnfavorite)
        XCTAssertEqual(displaySpy.invokedDisplayMovieUnfavoriteCount, 1)

        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplayEmptyView)
        XCTAssertFalse(displaySpy.invokedDisplayError)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedMovies)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedError)
    }

    func testPresentFailureShouldDisplayError() {
        sut.presentFailure()

        XCTAssertTrue(displaySpy.invokedDisplayError)
        XCTAssertEqual(displaySpy.invokedDisplayErrorCount, 1)

        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplayEmptyView)
        XCTAssertFalse(displaySpy.invokedDisplayMovieUnfavorite)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedMovies)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedError)
    }

    func testPresentSearchedMoviesShouldDisplaySearchedMovies() throws {
        let movies = MocksHelper.getMovies()
        let response = Favorites.FetchMoviesBySearch.Response(movies: movies)
        sut.presentSearchedMovies(response: response)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplaySearchedMoviesParameters)

        XCTAssertTrue(displaySpy.invokedDisplaySearchedMovies)
        XCTAssertEqual(displaySpy.invokedDisplaySearchedMoviesCount, 1)
        XCTAssertEqual(parameters.viewModel.movies, movies)
        XCTAssertEqual(displaySpy.invokedDisplaySearchedMoviesParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplayEmptyView)
        XCTAssertFalse(displaySpy.invokedDisplayMovieUnfavorite)
        XCTAssertFalse(displaySpy.invokedDisplayError)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedError)
    }

    func testPresentSearchedMoviesFailureShouldDisplaySearchedError() throws {
        let filter = FilterSearch(search: search, date: date, genres: genre)
        try presentSearchedMoviesFailure(filter: filter)
    }

    func testPresentSearchedMoviesFailureWithTextShouldDisplaySearchedError() throws {
        let filter = FilterSearch(search: search)
        try presentSearchedMoviesFailure(filter: filter)
    }

    func testPresentSearchedMoviesFailureWithDateShouldDisplaySearchedError() throws {
        let filter = FilterSearch(date: date)
        try presentSearchedMoviesFailure(filter: filter)
    }

    func testPresentSearchedMoviesFailureWithGenreShouldDisplaySearchedError() throws {
        let filter = FilterSearch(genres: genre)
        try presentSearchedMoviesFailure(filter: filter)
    }

    func testPresentSearchedMoviesFailureWithTextAndDateShouldDisplaySearchedError() throws {
        let filter = FilterSearch(search: search, date: date)
        try presentSearchedMoviesFailure(filter: filter)
    }

    func testPresentSearchedMoviesFailureWithTextAndGenreShouldDisplaySearchedError() throws {
        let filter = FilterSearch(search: search, genres: genre)
        try presentSearchedMoviesFailure(filter: filter)
    }

    func testPresentSearchedMoviesFailureWithDateAndGenreShouldDisplaySearchedError() throws {
        let filter = FilterSearch(date: date, genres: genre)
        try presentSearchedMoviesFailure(filter: filter)
    }

    func testPresentSearchedMoviesFailureWithEmptyFilterShouldDisplaySearchedError() throws {
        try presentSearchedMoviesFailure()
    }

    // MARK: - Private functions

    private func presentSearchedMoviesFailure(filter: FilterSearch = FilterSearch()) throws {
        sut.presentSearchedMoviesFailure(filter: filter)

        XCTAssertTrue(displaySpy.invokedDisplaySearchedError)
        XCTAssertEqual(displaySpy.invokedDisplaySearchedErrorCount, 1)
        XCTAssertEqual(displaySpy.invokedDisplaySearchedErrorParametersList.count, 1)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplaySearchedErrorParameters)

        if filter.isEmpty {
            XCTAssertEqual(parameters.searchedText, .empty)
        } else {
            if let search = filter.search {
                XCTAssertTrue(parameters.searchedText.localizedCaseInsensitiveContains(search))
            }

            if let genres = filter.genres {
                genres.forEach { genre in
                    XCTAssertTrue(parameters.searchedText.localizedCaseInsensitiveContains(genre))
                }
            }

            if let dates = filter.date {
                dates.forEach { date in
                    XCTAssertTrue(parameters.searchedText.localizedCaseInsensitiveContains(date))
                }
            }
        }

        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplayEmptyView)
        XCTAssertFalse(displaySpy.invokedDisplayMovieUnfavorite)
        XCTAssertFalse(displaySpy.invokedDisplayError)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedMovies)
    }
}

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

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertFalse(displaySpy.invokedDisplayLocalMovies)
        XCTAssertFalse(displaySpy.invokedDisplayFetchedLocalMoviesEmpty)
        XCTAssertFalse(displaySpy.invokedDisplayMovieUnfavorite)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
        XCTAssertFalse(displaySpy.invokedDisplayMoviesBySearch)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testPresentFetchedLocalMoviesShouldDisplayLocalMovies() throws {
        let movies = MocksHelper.getRandomMovies()
        let response = Favorites.FetchLocalMovies.Response(movies: movies)
        sut.presentFetchedLocalMovies(response: response)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplayLocalMoviesParameters)

        XCTAssertTrue(displaySpy.invokedDisplayLocalMovies)
        XCTAssertEqual(displaySpy.invokedDisplayLocalMoviesCount, 1)
        XCTAssertEqual(parameters.viewModel.movies, movies)
        XCTAssertEqual(displaySpy.invokedDisplayLocalMoviesParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedDisplayFetchedLocalMoviesEmpty)
        XCTAssertFalse(displaySpy.invokedDisplayMovieUnfavorite)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
        XCTAssertFalse(displaySpy.invokedDisplayMoviesBySearch)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testPresentFetchedLocalMoviesEmptyShouldDisplayLocalMoviesEmpty() {
        sut.presentFetchedLocalMoviesEmpty()

        XCTAssertTrue(displaySpy.invokedDisplayFetchedLocalMoviesEmpty)
        XCTAssertEqual(displaySpy.invokedDisplayFetchedLocalMoviesEmptyCount, 1)

        XCTAssertFalse(displaySpy.invokedDisplayLocalMovies)
        XCTAssertFalse(displaySpy.invokedDisplayMovieUnfavorite)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
        XCTAssertFalse(displaySpy.invokedDisplayMoviesBySearch)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testPresentMoviesUnfavoriteShouldDisplayMovieUnfavorite() {
        sut.presentMovieUnfavorite()

        XCTAssertTrue(displaySpy.invokedDisplayMovieUnfavorite)
        XCTAssertEqual(displaySpy.invokedDisplayMovieUnfavoriteCount, 1)

        XCTAssertFalse(displaySpy.invokedDisplayLocalMovies)
        XCTAssertFalse(displaySpy.invokedDisplayFetchedLocalMoviesEmpty)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
        XCTAssertFalse(displaySpy.invokedDisplayMoviesBySearch)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testPresentGenericFailureShouldDisplayGenericError() {
        sut.presentGenericFailure()

        XCTAssertTrue(displaySpy.invokedDisplayGenericError)
        XCTAssertEqual(displaySpy.invokedDisplayGenericErrorCount, 1)

        XCTAssertFalse(displaySpy.invokedDisplayLocalMovies)
        XCTAssertFalse(displaySpy.invokedDisplayFetchedLocalMoviesEmpty)
        XCTAssertFalse(displaySpy.invokedDisplayMovieUnfavorite)
        XCTAssertFalse(displaySpy.invokedDisplayMoviesBySearch)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testPresentFetchedMoviesBySearchShouldDisplayMoviesBySearch() throws {
        let movies = MocksHelper.getRandomMovies()
        let response = Favorites.FetchLocalMoviesBySearch.Response(movies: movies)
        sut.presentFetchedMoviesBySearch(response: response)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplayMoviesBySearchParameters)

        XCTAssertTrue(displaySpy.invokedDisplayMoviesBySearch)
        XCTAssertEqual(displaySpy.invokedDisplayMoviesBySearchCount, 1)
        XCTAssertEqual(parameters.viewModel.movies, movies)
        XCTAssertEqual(displaySpy.invokedDisplayMoviesBySearchParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedDisplayLocalMovies)
        XCTAssertFalse(displaySpy.invokedDisplayFetchedLocalMoviesEmpty)
        XCTAssertFalse(displaySpy.invokedDisplayMovieUnfavorite)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testPresentSearchedMoviesFailureShouldDisplaySearchError() throws {
        let filter = FilterSearch(search: Strings.mockDog.localizable)
        sut.presentSearchedMoviesFailure(filter: filter)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplaySearchErrorParameters)

        XCTAssertTrue(displaySpy.invokedDisplaySearchError)
        XCTAssertEqual(displaySpy.invokedDisplaySearchErrorCount, 1)
        XCTAssertEqual(parameters.searchedText, filter.search)
        XCTAssertEqual(displaySpy.invokedDisplaySearchErrorParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedDisplayLocalMovies)
        XCTAssertFalse(displaySpy.invokedDisplayFetchedLocalMoviesEmpty)
        XCTAssertFalse(displaySpy.invokedDisplayMovieUnfavorite)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
        XCTAssertFalse(displaySpy.invokedDisplayMoviesBySearch)
    }

    func testPresentSearchedMoviesFailureWithEmptySearchShouldDisplaySearchError() throws {
        let filter = FilterSearch()
        sut.presentSearchedMoviesFailure(filter: filter)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplaySearchErrorParameters)

        XCTAssertTrue(displaySpy.invokedDisplaySearchError)
        XCTAssertEqual(displaySpy.invokedDisplaySearchErrorCount, 1)
        XCTAssertEqual(parameters.searchedText, .empty)
        XCTAssertEqual(displaySpy.invokedDisplaySearchErrorParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedDisplayLocalMovies)
        XCTAssertFalse(displaySpy.invokedDisplayFetchedLocalMoviesEmpty)
        XCTAssertFalse(displaySpy.invokedDisplayMovieUnfavorite)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
        XCTAssertFalse(displaySpy.invokedDisplayMoviesBySearch)
    }
}

//
//  MoviesPresenterTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 09/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class MoviesPresenterTests: XCTestCase {
    private lazy var sut: MoviesPresenter = {
        let presenter = MoviesPresenter()
        presenter.viewController = displaySpy

        return presenter
    }()

    // MARK: - Private constants

    private let displaySpy = MoviesDisplaySpy()

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertFalse(displaySpy.invokedOnFetchedLocalMovies)
        XCTAssertFalse(displaySpy.invokedOnFetchedGenres)
        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
        XCTAssertFalse(displaySpy.invokedDisplayMoviesBySearch)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testFetchedLocalMoviesShouldCallOnFetchedLocalMovies() throws {
        let movies = MocksHelper.getRandomMovies()
        let viewModel = Movies.FetchLocalMovies.Response(movies: movies)
        sut.presentFetchedLocalMovies(response: viewModel)

        let parameters = try XCTUnwrap(displaySpy.invokedOnFetchedLocalMoviesParameters)

        XCTAssertTrue(displaySpy.invokedOnFetchedLocalMovies)
        XCTAssertEqual(displaySpy.invokedOnFetchedLocalMoviesCount, 1)
        XCTAssertEqual(parameters.viewModel.movies, movies)
        XCTAssertEqual(displaySpy.invokedOnFetchedLocalMoviesParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedOnFetchedGenres)
        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
        XCTAssertFalse(displaySpy.invokedDisplayMoviesBySearch)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testFetchedGenresShouldCallOnFetchedGenres() throws {
        let genreResponse = GenresResponse(path: JSONMocks.genresResponse.rawValue)
        let viewModel = Movies.FetchGenres.Response(genres: genreResponse.genres)
        sut.presentFetchedGenres(response: viewModel)

        let parameters = try XCTUnwrap(displaySpy.invokedOnFetchedGenresParameters)

        XCTAssertTrue(displaySpy.invokedOnFetchedGenres)
        XCTAssertEqual(displaySpy.invokedOnFetchedGenresCount, 1)
        XCTAssertEqual(parameters.viewModel.genres.count, genreResponse.genres.count)
        XCTAssertEqual(displaySpy.invokedOnFetchedGenresParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedOnFetchedLocalMovies)
        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
        XCTAssertFalse(displaySpy.invokedDisplayMoviesBySearch)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testPresentFetchedMoviesShoulDisplayMovies() throws {
        let movies = MocksHelper.getRandomMovies()
        let viewModel = Movies.FetchMovies.Response(page: Constants.MovieDefaultParameters.page, totalPages: 500, movies: movies)
        sut.presentFetchedMovies(response: viewModel)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplayMoviesParameters)

        XCTAssertTrue(displaySpy.invokedDisplayMovies)
        XCTAssertEqual(displaySpy.invokedDisplayMoviesCount, 1)
        XCTAssertEqual(parameters.viewModel.page, Constants.MovieDefaultParameters.page)
        XCTAssertEqual(parameters.viewModel.totalPages, 500)
        XCTAssertEqual(parameters.viewModel.movies, movies)
        XCTAssertEqual(displaySpy.invokedDisplayMoviesParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedOnFetchedLocalMovies)
        XCTAssertFalse(displaySpy.invokedOnFetchedGenres)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
        XCTAssertFalse(displaySpy.invokedDisplayMoviesBySearch)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testFetchedFailureShouldDisplayGenericError() {
        sut.presentFailure()

        XCTAssertTrue(displaySpy.invokedDisplayGenericError)
        XCTAssertEqual(displaySpy.invokedDisplayGenericErrorCount, 1)

        XCTAssertFalse(displaySpy.invokedOnFetchedLocalMovies)
        XCTAssertFalse(displaySpy.invokedOnFetchedGenres)
        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplayMoviesBySearch)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testFetchedMoviesBySearchShouldDisplayMoviesBySearch() throws {
        let movies = MocksHelper.getRandomMovies()
        let viewModel = Movies.FetchMoviesBySearch.Response(movies: movies)
        sut.presentFetchedMoviesBySearch(response: viewModel)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplayMoviesBySearchParameters)

        XCTAssertTrue(displaySpy.invokedDisplayMoviesBySearch)
        XCTAssertEqual(displaySpy.invokedDisplayMoviesBySearchCount, 1)
        XCTAssertEqual(parameters.viewModel.movies, movies)
        XCTAssertEqual(displaySpy.invokedDisplayMoviesBySearchParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedOnFetchedLocalMovies)
        XCTAssertFalse(displaySpy.invokedOnFetchedGenres)
        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testSearchMoviesFailureShouldDisplaySearchError() throws {
        let search = Strings.mockDog.localizable
        sut.presentSearchedFailure(textSearched: search)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplaySearchErrorParameters)

        XCTAssertTrue(displaySpy.invokedDisplaySearchError)
        XCTAssertEqual(displaySpy.invokedDisplaySearchErrorCount, 1)
        XCTAssertEqual(parameters.searchedText, search)
        XCTAssertEqual(displaySpy.invokedDisplaySearchErrorParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedOnFetchedLocalMovies)
        XCTAssertFalse(displaySpy.invokedOnFetchedGenres)
        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
        XCTAssertFalse(displaySpy.invokedDisplayMoviesBySearch)
    }
}

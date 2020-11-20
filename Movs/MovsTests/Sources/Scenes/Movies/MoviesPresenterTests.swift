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
        presenter.viewController = viewSpy

        return presenter
    }()

    // MARK: - Private constants

    private let viewSpy = MoviesViewSpy()

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertFalse(viewSpy.invokedOnFetchedLocalMovies)
        XCTAssertFalse(viewSpy.invokedOnFetchedGenres)
        XCTAssertFalse(viewSpy.invokedDisplayMovies)
        XCTAssertFalse(viewSpy.invokedDisplayGenericError)
        XCTAssertFalse(viewSpy.invokedDisplayMoviesBySearch)
        XCTAssertFalse(viewSpy.invokedDisplaySearchError)
    }

    func testFetchedLocalMoviesShouldCallOnFetchedLocalMovies() {
        let movies = MocksHelper.getRandomMovies()
        let viewModel = Movies.FetchLocalMovies.Response(movies: movies)
        sut.presentFetchedLocalMovies(response: viewModel)

        XCTAssertTrue(viewSpy.invokedOnFetchedLocalMovies)
        XCTAssertEqual(viewSpy.invokedOnFetchedLocalMoviesCount, 1)
        XCTAssertEqual(viewSpy.invokedOnFetchedLocalMoviesParameters?.viewModel.movies, movies)
        XCTAssertEqual(viewSpy.invokedOnFetchedLocalMoviesParameters?.viewModel.movies.count, movies.count)
        XCTAssertEqual(viewSpy.invokedOnFetchedLocalMoviesParametersList.count, 1)

        XCTAssertFalse(viewSpy.invokedOnFetchedGenres)
        XCTAssertFalse(viewSpy.invokedDisplayMovies)
        XCTAssertFalse(viewSpy.invokedDisplayGenericError)
        XCTAssertFalse(viewSpy.invokedDisplayMoviesBySearch)
        XCTAssertFalse(viewSpy.invokedDisplaySearchError)
    }

    func testFetchedGenresShouldCallOnFetchedGenres() throws {
        let genreResponse = try XCTUnwrap(MocksHelper.getMockedGenres())
        let viewModel = Movies.FetchGenres.Response(genres: genreResponse.genres)
        sut.presentFetchedGenres(response: viewModel)

        XCTAssertTrue(viewSpy.invokedOnFetchedGenres)
        XCTAssertEqual(viewSpy.invokedOnFetchedGenresCount, 1)
        XCTAssertEqual(viewSpy.invokedOnFetchedGenresParameters?.viewModel.genres.count, genreResponse.genres.count)
        XCTAssertEqual(viewSpy.invokedOnFetchedGenresParametersList.count, 1)

        XCTAssertFalse(viewSpy.invokedOnFetchedLocalMovies)
        XCTAssertFalse(viewSpy.invokedDisplayMovies)
        XCTAssertFalse(viewSpy.invokedDisplayGenericError)
        XCTAssertFalse(viewSpy.invokedDisplayMoviesBySearch)
        XCTAssertFalse(viewSpy.invokedDisplaySearchError)
    }

    func testPresentFetchedMoviesShoulDisplayMovies() {
        let movies = MocksHelper.getRandomMovies()
        let viewModel = Movies.FetchMovies.Response(page: Constants.MovieDefaultParameters.page, totalPages: 500, movies: movies)
        sut.presentFetchedMovies(response: viewModel)

        XCTAssertTrue(viewSpy.invokedDisplayMovies)
        XCTAssertEqual(viewSpy.invokedDisplayMoviesCount, 1)
        XCTAssertEqual(viewSpy.invokedDisplayMoviesParameters?.viewModel.page, Constants.MovieDefaultParameters.page)
        XCTAssertEqual(viewSpy.invokedDisplayMoviesParameters?.viewModel.totalPages, 500)
        XCTAssertEqual(viewSpy.invokedDisplayMoviesParameters?.viewModel.movies, movies)
        XCTAssertEqual(viewSpy.invokedDisplayMoviesParameters?.viewModel.movies.count, movies.count)
        XCTAssertEqual(viewSpy.invokedDisplayMoviesParametersList.count, 1)

        XCTAssertFalse(viewSpy.invokedOnFetchedLocalMovies)
        XCTAssertFalse(viewSpy.invokedOnFetchedGenres)
        XCTAssertFalse(viewSpy.invokedDisplayGenericError)
        XCTAssertFalse(viewSpy.invokedDisplayMoviesBySearch)
        XCTAssertFalse(viewSpy.invokedDisplaySearchError)
    }

    func testFetchedFailureShouldDisplayGenericError() {
        sut.presentFetchedFailure()

        XCTAssertTrue(viewSpy.invokedDisplayGenericError)
        XCTAssertEqual(viewSpy.invokedDisplayGenericErrorCount, 1)

        XCTAssertFalse(viewSpy.invokedOnFetchedLocalMovies)
        XCTAssertFalse(viewSpy.invokedOnFetchedGenres)
        XCTAssertFalse(viewSpy.invokedDisplayMovies)
        XCTAssertFalse(viewSpy.invokedDisplayMoviesBySearch)
        XCTAssertFalse(viewSpy.invokedDisplaySearchError)
    }

    func testFetchedMoviesBySearchShouldDisplayMoviesBySearch() {
        let movies = MocksHelper.getRandomMovies()
        let viewModel = Movies.FetchLocalMoviesBySearch.Response(movies: movies)
        sut.presentFetchedMoviesBySearch(response: viewModel)

        XCTAssertTrue(viewSpy.invokedDisplayMoviesBySearch)
        XCTAssertEqual(viewSpy.invokedDisplayMoviesBySearchCount, 1)
        XCTAssertEqual(viewSpy.invokedDisplayMoviesBySearchParameters?.viewModel.movies, movies)
        XCTAssertEqual(viewSpy.invokedDisplayMoviesBySearchParameters?.viewModel.movies.count, movies.count)
        XCTAssertEqual(viewSpy.invokedDisplayMoviesBySearchParametersList.count, 1)

        XCTAssertFalse(viewSpy.invokedOnFetchedLocalMovies)
        XCTAssertFalse(viewSpy.invokedOnFetchedGenres)
        XCTAssertFalse(viewSpy.invokedDisplayMovies)
        XCTAssertFalse(viewSpy.invokedDisplayGenericError)
        XCTAssertFalse(viewSpy.invokedDisplaySearchError)
    }

    func testSearchMoviesFailureShouldDisplaySearchError() {
        let search = Strings.mockDog.localizable
        sut.presentSearchedMoviesFailure(textSearched: search)

        XCTAssertTrue(viewSpy.invokedDisplaySearchError)
        XCTAssertEqual(viewSpy.invokedDisplaySearchErrorCount, 1)
        XCTAssertEqual(viewSpy.invokedDisplaySearchErrorParameters?.searchedText, search)
        XCTAssertEqual(viewSpy.invokedDisplaySearchErrorParametersList.count, 1)

        XCTAssertFalse(viewSpy.invokedOnFetchedLocalMovies)
        XCTAssertFalse(viewSpy.invokedOnFetchedGenres)
        XCTAssertFalse(viewSpy.invokedDisplayMovies)
        XCTAssertFalse(viewSpy.invokedDisplayGenericError)
        XCTAssertFalse(viewSpy.invokedDisplayMoviesBySearch)
    }
}

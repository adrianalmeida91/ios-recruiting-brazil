//
//  MoviesInteractorTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 08/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class MoviesInteractorTests: XCTestCase {
    private lazy var sut = MoviesInteractor(realmWorker: realmWorkerSpy, moyaWorker: moyaWorkerSpy, presenter: presenterSpy)

    // MARK: - Private constants

    private let realmWorkerSpy = RealmWorkerSpy()

    private let moyaWorkerSpy = MoyaWorkerSpy()

    private let presenterSpy = MoviesPresenterSpy()

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchGenres)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedGenres)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedFailure)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
    }

    func testFetchLocalMoviesShouldPresentFetchedLocalMovies() throws {
        let movies = MocksHelper.getRandomMovies()
        realmWorkerSpy.stubbedFetchMoviesCompletionResult = (.success(movies), ())

        sut.fetchLocalMovies()

        let parameters = try XCTUnwrap(presenterSpy.invokedPresentFetchedLocalMoviesParameters)

        XCTAssertTrue(realmWorkerSpy.invokedFetchMovies)
        XCTAssertEqual(realmWorkerSpy.invokedFetchMoviesCount, 1)
        XCTAssertTrue(presenterSpy.invokedPresentFetchedLocalMovies)
        XCTAssertEqual(presenterSpy.invokedPresentFetchedLocalMoviesCount, 1)
        XCTAssertEqual(parameters.response.movies, movies)
        XCTAssertEqual(presenterSpy.invokedPresentFetchedLocalMoviesParametersList.count, 1)

        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchGenres)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedGenres)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedFailure)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
    }

    func testFetchLocalMoviesShouldPresentGenericError() {
        realmWorkerSpy.stubbedFetchMoviesCompletionResult = (.failure(.unknown), ())

        sut.fetchLocalMovies()

        XCTAssertTrue(realmWorkerSpy.invokedFetchMovies)
        XCTAssertEqual(realmWorkerSpy.invokedFetchMoviesCount, 1)
        XCTAssertTrue(presenterSpy.invokedPresentFetchedFailure)
        XCTAssertEqual(presenterSpy.invokedPresentFetchedFailureCount, 1)

        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchGenres)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedGenres)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
    }

    func testFetchGenresShouldPresentFetchedGenres() throws {
        let genres = GenresResponse(path: JSONMocks.genresResponse.rawValue)
        moyaWorkerSpy.stubbedFetchGenresCompletionResult = (.success(genres), ())

        let request = Movies.FetchGenres.Request(language: Constants.MovieDefaultParameters.language)
        sut.fetchGenres(request: request)

        let workerParameters = try XCTUnwrap(moyaWorkerSpy.invokedFetchGenresParameters)
        let presenterParameters = try XCTUnwrap(presenterSpy.invokedPresentFetchedGenresParameters)

        XCTAssertTrue(moyaWorkerSpy.invokedFetchGenres)
        XCTAssertEqual(moyaWorkerSpy.invokedFetchGenresCount, 1)
        XCTAssertEqual(workerParameters.language, Constants.MovieDefaultParameters.language)
        XCTAssertEqual(moyaWorkerSpy.invokedFetchGenresParametersList.count, 1)
        XCTAssertTrue(presenterSpy.invokedPresentFetchedGenres)
        XCTAssertEqual(presenterSpy.invokedPresentFetchedGenresCount, 1)
        XCTAssertEqual(presenterParameters.response.genres.count, genres.genres.count)
        XCTAssertEqual(presenterSpy.invokedPresentFetchedGenresParametersList.count, 1)

        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedFailure)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
    }

    func testFetchGenresShouldPresentGenericError() {
        moyaWorkerSpy.stubbedFetchGenresCompletionResult = (.failure(.unknown), ())

        let request = Movies.FetchGenres.Request(language: Constants.MovieDefaultParameters.language)
        sut.fetchGenres(request: request)

        XCTAssertTrue(moyaWorkerSpy.invokedFetchGenres)
        XCTAssertEqual(moyaWorkerSpy.invokedFetchGenresCount, 1)
        XCTAssertTrue(presenterSpy.invokedPresentFetchedFailure)
        XCTAssertEqual(presenterSpy.invokedPresentFetchedFailureCount, 1)

        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedGenres)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
    }

    func testFetchMoviesShouldPresentFetchedMovies() throws {
        let moviesPopulariesResponse = MoviesPopulariesResponse(path: JSONMocks.moviesPopulariesResponse.rawValue)
        let genres = GenresResponse(path: JSONMocks.genresResponse.rawValue)

        moyaWorkerSpy.stubbedFetchMoviesCompletionResult = ((.success(moviesPopulariesResponse)), ())

        let request = Movies.FetchMovies.Request(language: Constants.MovieDefaultParameters.language, page: Constants.MovieDefaultParameters.page, genres: genres.genres)
        sut.fetchMovies(request: request)

        let parameters = try XCTUnwrap(moyaWorkerSpy.invokedFetchMoviesParameters)

        XCTAssertTrue(moyaWorkerSpy.invokedFetchMovies)
        XCTAssertEqual(moyaWorkerSpy.invokedFetchMoviesCount, 1)
        XCTAssertEqual(parameters.language, Constants.MovieDefaultParameters.language)
        XCTAssertEqual(parameters.page, Constants.MovieDefaultParameters.page)
        XCTAssertEqual(moyaWorkerSpy.invokedFetchMoviesParametersList.count, 1)
        XCTAssertTrue(presenterSpy.invokedPresentFetchedMovies)
        XCTAssertEqual(presenterSpy.invokedPresentFetchedMoviesCount, 1)

        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchGenres)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedGenres)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedFailure)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
    }

    func testFetchMoviesShouldPresentGenericError() {
        moyaWorkerSpy.stubbedFetchMoviesCompletionResult = ((.failure(.unknown)), ())

        let request = Movies.FetchMovies.Request(language: Constants.MovieDefaultParameters.language, page: Constants.MovieDefaultParameters.page, genres: [])
        sut.fetchMovies(request: request)

        XCTAssertTrue(moyaWorkerSpy.invokedFetchMovies)
        XCTAssertEqual(moyaWorkerSpy.invokedFetchMoviesCount, 1)
        XCTAssertTrue(presenterSpy.invokedPresentFetchedFailure)
        XCTAssertEqual(presenterSpy.invokedPresentFetchedFailureCount, 1)

        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchGenres)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedGenres)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
    }

    func testFetchLocalMoviesBySearchShouldPresentFetchedMoviesBySearch() throws {
        let movies = MocksHelper.getMockedMovies()
        let search = Strings.mockKill.localizable
        let request = Movies.FetchMoviesBySearch.Request(movies: movies, filter: search)
        sut.fetchLocalMoviesBySearch(request: request)

        let moviesFiltered = try XCTUnwrap(presenterSpy.invokedPresentFetchedMoviesBySearchParameters).response.movies

        XCTAssertTrue(presenterSpy.invokedPresentFetchedMoviesBySearch)
        XCTAssertEqual(presenterSpy.invokedPresentFetchedMoviesBySearchCount, 1)
        XCTAssertTrue(moviesFiltered.count > 0)
        XCTAssertEqual(presenterSpy.invokedPresentFetchedMoviesBySearchParametersList.count, 1)

        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchGenres)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedGenres)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedFailure)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
    }

    func testFetchLocalMoviesBySearchShouldPresentSearchedMoviesFailure() {
        let movies = MocksHelper.getMockedMovies()
        let search = String(repeating: "a", count: Int.random(in: 10...50))
        let request = Movies.FetchMoviesBySearch.Request(movies: movies, filter: search)
        sut.fetchLocalMoviesBySearch(request: request)

        XCTAssertTrue(presenterSpy.invokedPresentSearchedMoviesFailure)
        XCTAssertEqual(presenterSpy.invokedPresentSearchedMoviesFailureCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentSearchedMoviesFailureParameters?.textSearched, search)
        XCTAssertEqual(presenterSpy.invokedPresentSearchedMoviesFailureParametersList.count, 1)

        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchGenres)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedGenres)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedFailure)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
    }

    func testFetchLocalMoviesBySearchShouldReturnWithEmptySearch() {
        let movies = MocksHelper.getMockedMovies()
        let search: String = .empty
        let request = Movies.FetchMoviesBySearch.Request(movies: movies, filter: search)
        sut.fetchLocalMoviesBySearch(request: request)

        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchGenres)
        XCTAssertFalse(moyaWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedGenres)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedFailure)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
    }
}

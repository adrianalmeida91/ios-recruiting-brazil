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
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFailure)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedFailure)
    }

    func testFetchMoviesShouldPresentFetchedMovies() throws {
        try fetchMoviesRequestWithMockValues()
    }

    func testFetchLocalMoviesShouldPresentFailure() throws {
        try fetchMoviesRequestWithMockValues(isMoviesSuccess: false)
    }

    func testFetchGenresShouldPresentFailure() throws {
        try fetchMoviesRequestWithMockValues(isGenresSuccess: false)
    }

    func testFetchMoviesShouldPresentFailure() throws {
        try fetchMoviesRequestWithMockValues(isMoviesPopulariesSuccess: false)
    }

    func testFetchMoviesBySearchShoulPresentSearchedMovies() throws {
        let search = MocksHelper.Strings.search.rawValue
        try mockMoviesAndSearch(search: search)

        let parameters = try XCTUnwrap(presenterSpy.invokedPresentSearchedMoviesParameters)

        XCTAssertTrue(presenterSpy.invokedPresentSearchedMovies)
        XCTAssertEqual(presenterSpy.invokedPresentSearchedMoviesCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentSearchedMoviesParametersList.count, 1)

        parameters.response.movies.forEach { movie in
            XCTAssertTrue(movie.title.localizedCaseInsensitiveContains(search))
        }
    }

    func testFetchMoviesBySearchShouldPresentFailure() throws {
        try mockMoviesAndSearch(search: MocksHelper.Strings.searchError.rawValue)

        XCTAssertFalse(presenterSpy.invokedPresentSearchedMovies)
    }

    func testFetchMoviesByEmptySearchShouldDoNothing() throws {
        try mockMoviesAndSearch(search: .empty)

        XCTAssertFalse(presenterSpy.invokedPresentFailure)
    }

    // MARK: - Private functions

    private func fetchMoviesRequestWithMockValues(isMoviesSuccess: Bool = true, isGenresSuccess: Bool = true, isMoviesPopulariesSuccess: Bool = true) throws {
        let movies = MocksHelper.getMovies()
        realmWorkerSpy.stubbedFetchMoviesCompletionResult = isMoviesSuccess ? (.success(movies), ()) : (.failure(MocksHelper.Error.test), ())

        let genresResponse = GenresResponse(path: JSONMocks.genresResponse.rawValue)
        moyaWorkerSpy.stubbedFetchGenresCompletionResult = isGenresSuccess ? (.success(genresResponse), ()) : (.failure(MocksHelper.Error.test), ())

        let moviesPopulariesResponse = MoviesPopulariesResponse(path: JSONMocks.moviesPopulariesResponse.rawValue)
        moyaWorkerSpy.stubbedFetchMoviesCompletionResult = isMoviesPopulariesSuccess ? (.success(moviesPopulariesResponse), ()) : (.failure(MocksHelper.Error.test), ())

        let request = Movies.FetchMovies.Request(language: Constants.MovieDefaultParameters.language, page: Constants.MovieDefaultParameters.page)
        sut.fetchMovies(request: request)

        XCTAssertTrue(realmWorkerSpy.invokedFetchMovies)
        XCTAssertEqual(realmWorkerSpy.invokedFetchMoviesCount, 1)

        let genresParameters = try XCTUnwrap(moyaWorkerSpy.invokedFetchGenresParameters)

        XCTAssertTrue(moyaWorkerSpy.invokedFetchGenres)
        XCTAssertEqual(moyaWorkerSpy.invokedFetchGenresCount, 1)
        XCTAssertEqual(genresParameters.language, request.language)
        XCTAssertEqual(moyaWorkerSpy.invokedFetchGenresParametersList.count, 1)

        let fetchMoviesParameters = try XCTUnwrap(moyaWorkerSpy.invokedFetchMoviesParameters)

        XCTAssertTrue(moyaWorkerSpy.invokedFetchMovies)
        XCTAssertEqual(moyaWorkerSpy.invokedFetchMoviesCount, 1)
        XCTAssertEqual(fetchMoviesParameters.language, request.language)
        XCTAssertEqual(fetchMoviesParameters.page, request.page)
        XCTAssertEqual(moyaWorkerSpy.invokedFetchMoviesParametersList.count, 1)

        if isMoviesSuccess, isGenresSuccess, isMoviesPopulariesSuccess {
            let fetchedMoviesParameters = try XCTUnwrap(presenterSpy.invokedPresentFetchedMoviesParameters)

            XCTAssertTrue(presenterSpy.invokedPresentFetchedMovies)
            XCTAssertEqual(presenterSpy.invokedPresentFetchedMoviesCount, 1)
            XCTAssertEqual(fetchedMoviesParameters.response.page, 1)
            XCTAssertEqual(fetchedMoviesParameters.response.totalPages, 500)
            XCTAssertEqual(fetchedMoviesParameters.response.movies.count, 20)
            XCTAssertEqual(presenterSpy.invokedPresentFetchedMoviesParametersList.count, 1)
            XCTAssertFalse(presenterSpy.invokedPresentFailure)
        } else {
            XCTAssertTrue(presenterSpy.invokedPresentFailure)
            XCTAssertEqual(presenterSpy.invokedPresentFailureCount, 1)
            XCTAssertFalse(presenterSpy.invokedPresentFetchedMovies)
        }

        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedFailure)
    }

    private func mockMoviesAndSearch(search: String) throws {
        try fetchMoviesRequestWithMockValues()

        let request = Movies.FetchMoviesBySearch.Request(filter: search)
        sut.fetchMoviesBySearch(request: request)
    }
}

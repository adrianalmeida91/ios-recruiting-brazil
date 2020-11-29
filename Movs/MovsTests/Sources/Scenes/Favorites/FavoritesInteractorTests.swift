//
//  FavoritesInteractorTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class FavoritesInteractorTests: XCTestCase {
    private lazy var sut = FavoritesInteractor(worker: realmWorkerSpy, presenter: presenterSpy)

    // MARK: - Private constants

    private let realmWorkerSpy = RealmWorkerSpy()

    private let presenterSpy = FavoritesPresenterSpy()

    private let search = MocksHelper.Strings.search.rawValue

    private let date = [MocksHelper.Dates.y2020.rawValue]

    private let genre = [MocksHelper.Genres.action.rawValue]

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentEmptyView)
        XCTAssertFalse(presenterSpy.invokedPresentMovieUnfavorite)
        XCTAssertFalse(presenterSpy.invokedPresentFailure)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
    }

    func testFetchMoviesShouldPresentFetchedMovies() throws {
        let movies = MocksHelper.getMovies()
        try fetchMoviesRequestWithMockValues(movies: movies)
    }

    func testFetchMoviesShouldPresentEmptyView() throws {
        try fetchMoviesRequestWithMockValues()
    }

    func testFetchMoviesShouldPresentFailure() throws {
        try fetchMoviesRequestWithMockValues(isSuccess: false)
    }

    func testFetchMoviesBySearchShouldPresentSearchedMovies() throws {
        let movies = MocksHelper.getMovies()
        let filter = FilterSearch(search: search, date: date, genres: genre)
        try fetchMoviesBySearchRequestWithMockValues(movies: movies, filter: filter)
    }

    func testFetchMoviesBySearchWithTextShouldPresentSearchedMovies() throws {
        let movies = MocksHelper.getMovies()
        let filter = FilterSearch(search: search)
        try fetchMoviesBySearchRequestWithMockValues(movies: movies, filter: filter)
    }

    func testFetchMoviesBySearchWithDateShouldPresentSearchedMovies() throws {
        let movies = MocksHelper.getMovies()
        let filter = FilterSearch(date: date)
        try fetchMoviesBySearchRequestWithMockValues(movies: movies, filter: filter)
    }

    func testFetchMoviesBySearchWithGenreShouldPresentSearchedMovies() throws {
        let movies = MocksHelper.getMovies()
        let filter = FilterSearch(genres: genre)
        try fetchMoviesBySearchRequestWithMockValues(movies: movies, filter: filter)
    }

    func testFetchMoviesBySearchWithTextAndDateShouldPresentSearchedMovies() throws {
        let movies = MocksHelper.getMovies()
        let filter = FilterSearch(search: search, date: date)
        try fetchMoviesBySearchRequestWithMockValues(movies: movies, filter: filter)
    }

    func testFetchMoviesBySearchWithTextAndGenreShouldPresentSearchedMovies() throws {
        let movies = MocksHelper.getMovies()
        let filter = FilterSearch(search: search, genres: genre)
        try fetchMoviesBySearchRequestWithMockValues(movies: movies, filter: filter)
    }

    func testFetchMoviesBySearchWithDateAndGenreShouldPresentSearchedMovies() throws {
        let movies = MocksHelper.getMovies()
        let filter = FilterSearch(date: date, genres: genre)
        try fetchMoviesBySearchRequestWithMockValues(movies: movies, filter: filter)
    }

    func testFetchMoviesBySearchWithEmptyMovieShouldPresentFailure() throws {
        try fetchMoviesBySearchRequestWithMockValues()
    }

    func testFetchMoviesBySearchWithTextShouldPresentFailure() throws {
        let movies = MocksHelper.getMovies()
        let filter = FilterSearch(search: MocksHelper.Strings.searchError.rawValue)
        try fetchMoviesBySearchRequestWithMockValues(movies: movies, filter: filter)
    }

    func testFetchMoviesBySearchWithDateShouldPresentFailure() throws {
        let movies = MocksHelper.getMovies()
        let filter = FilterSearch(date: [MocksHelper.Strings.dateError.rawValue])
        try fetchMoviesBySearchRequestWithMockValues(movies: movies, filter: filter)
    }

    func testFetchMoviesBySearchWithGenreShouldPresentFailure() throws {
        let movies = MocksHelper.getMovies()
        let filter = FilterSearch(genres: [MocksHelper.Strings.genreError.rawValue])
        try fetchMoviesBySearchRequestWithMockValues(movies: movies, filter: filter)
    }

    func testFetchMoviesBySearchWithMovieWithoutGenresShouldPresentFailure() throws {
        let movies = MocksHelper.getMovies().map { movie -> Movie in
            let movieWithoutGenres = movie
            movie.genres = nil
            return movieWithoutGenres
        }
        let filter = FilterSearch(genres: [MocksHelper.Strings.genreError.rawValue])
        try fetchMoviesBySearchRequestWithMockValues(movies: movies, filter: filter)
    }

    func testDeleteMovieShouldPresentMovieUnfavorite() throws {
        try deleteMovieRequestWithMockValues()
    }

    func testDeleteMovieShouldPresentFailure() throws {
        try deleteMovieRequestWithMockValues(isSuccess: false)
    }

    // MARK: - Private functions

    private func fetchMoviesRequestWithMockValues(movies: [Movie] = [], isSuccess: Bool = true) throws {
        realmWorkerSpy.stubbedFetchMoviesCompletionResult = isSuccess ? (.success(movies), ()) : (.failure(MocksHelper.Error.test), ())
        sut.fetchMovies()

        XCTAssertTrue(realmWorkerSpy.invokedFetchMovies)
        XCTAssertEqual(realmWorkerSpy.invokedFetchMoviesCount, 1)

        if !isSuccess {
            XCTAssertTrue(presenterSpy.invokedPresentFailure)
            XCTAssertEqual(presenterSpy.invokedPresentFailureCount, 1)
        } else if movies.isEmpty {
            verifyEmptyView()
        } else {
            let parameters = try XCTUnwrap(presenterSpy.invokedPresentFetchedMoviesParameters)

            XCTAssertTrue(presenterSpy.invokedPresentFetchedMovies)
            XCTAssertEqual(presenterSpy.invokedPresentFetchedMoviesCount, 1)
            XCTAssertEqual(parameters.response.movies, movies)
            XCTAssertEqual(presenterSpy.invokedPresentFetchedMoviesParametersList.count, 1)
            XCTAssertFalse(presenterSpy.invokedPresentEmptyView)
            XCTAssertFalse(presenterSpy.invokedPresentFailure)
        }

        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
        XCTAssertFalse(presenterSpy.invokedPresentMovieUnfavorite)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
    }

    private func fetchMoviesBySearchRequestWithMockValues(movies: [Movie] = [], filter: FilterSearch = FilterSearch()) throws {
        try fetchMoviesRequestWithMockValues(movies: movies)

        let request = Favorites.FetchMoviesBySearch.Request(filter: filter)
        sut.fetchMoviesBySearch(request: request)

        if movies.isEmpty {
            verifyEmptyView()
        } else {
            let parameters = presenterSpy.invokedPresentSearchedMoviesParameters

            if let parameters = parameters {
                XCTAssertTrue(presenterSpy.invokedPresentSearchedMovies)
                XCTAssertEqual(presenterSpy.invokedPresentSearchedMoviesCount, 1)
                XCTAssertEqual(presenterSpy.invokedPresentSearchedMoviesParametersList.count, 1)

                try parameters.response.movies.forEach { movie in
                    if let search = filter.search {
                        XCTAssertTrue(movie.title.localizedCaseInsensitiveContains(search))
                    }

                    if let date = filter.date {
                        XCTAssertTrue(date.contains(movie.releaseDate))
                    }

                    if let genres = filter.genres {
                        let movieGenres = try XCTUnwrap(movie.genres)

                        genres.forEach { genres in
                            XCTAssertTrue(movieGenres.localizedCaseInsensitiveContains(genres))
                        }
                    }

                    XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
                }
            } else {
                let failureParameters = try XCTUnwrap(presenterSpy.invokedPresentSearchedMoviesFailureParameters)

                XCTAssertTrue(presenterSpy.invokedPresentSearchedMoviesFailure)
                XCTAssertEqual(presenterSpy.invokedPresentSearchedMoviesFailureCount, 1)
                XCTAssertEqual(failureParameters.filter.search, filter.search)
                XCTAssertEqual(failureParameters.filter.genres, filter.genres)
                XCTAssertEqual(failureParameters.filter.date, filter.date)
                XCTAssertEqual(presenterSpy.invokedPresentSearchedMoviesFailureParametersList.count, 1)

                XCTAssertFalse(presenterSpy.invokedPresentSearchedMovies)
            }

            XCTAssertFalse(presenterSpy.invokedPresentEmptyView)
        }

        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
        XCTAssertFalse(presenterSpy.invokedPresentMovieUnfavorite)
        XCTAssertFalse(presenterSpy.invokedPresentFailure)
    }

    private func verifyEmptyView() {
        XCTAssertTrue(presenterSpy.invokedPresentEmptyView)
        XCTAssertEqual(presenterSpy.invokedPresentEmptyViewCount, 1)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentFailure)
    }

    private func deleteMovieRequestWithMockValues(isSuccess: Bool = true) throws {
        let movies = MocksHelper.getMovies()
        try fetchMoviesRequestWithMockValues(movies: movies)

        realmWorkerSpy.stubbedDeleteMovieCompletionResult = isSuccess ? (.success(()), ()) : (.failure(MocksHelper.Error.test), ())

        let request = Favorites.DeleteMovie.Request(movie: movies[0])
        sut.deleteMovie(request: request)

        let parameters = try XCTUnwrap(realmWorkerSpy.invokedDeleteMovieParameters)

        XCTAssertTrue(realmWorkerSpy.invokedDeleteMovie)
        XCTAssertEqual(realmWorkerSpy.invokedDeleteMovieCount, 1)
        XCTAssertEqual(parameters.movie, movies[0])
        XCTAssertEqual(realmWorkerSpy.invokedDeleteMovieParametersList.count, 1)

        if isSuccess {
            XCTAssertTrue(presenterSpy.invokedPresentMovieUnfavorite)
            XCTAssertEqual(presenterSpy.invokedPresentMovieUnfavoriteCount, 1)
            XCTAssertFalse(presenterSpy.invokedPresentFailure)
        } else {
            XCTAssertTrue(presenterSpy.invokedPresentFailure)
            XCTAssertEqual(presenterSpy.invokedPresentFailureCount, 1)
            XCTAssertFalse(presenterSpy.invokedPresentMovieUnfavorite)
        }

        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
        XCTAssertFalse(presenterSpy.invokedPresentEmptyView)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMovies)
        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
    }
}

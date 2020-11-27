//
//  FavoritesInteractorTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

//final class FavoritesInteractorTests: XCTestCase {
//    private lazy var sut = FavoritesInteractor(worker: realmWorkerSpy, presenter: presenterSpy)
//
//    // MARK: - Private constants
//
//    private let realmWorkerSpy = RealmWorkerSpy()
//
//    private let presenterSpy = FavoritesPresenterSpy()
//
//    private let movies = MocksHelper.getMockedMovies()
//
//    // MARK: - Test functions
//
//    func testInitialization() {
//        _ = sut
//
//        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
//        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
//        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMoviesEmpty)
//        XCTAssertFalse(presenterSpy.invokedPresenterMovieUnfavorite)
//        XCTAssertFalse(presenterSpy.invokedPresentGenericFailure)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
//        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
//    }
//
//    func testFetchLocalMoviesShouldPresentFetchedLocalMovies() throws {
//        realmWorkerSpy.stubbedFetchMoviesCompletionResult = (.success(movies), ())
//        sut.fetchMovies()
//
//        let parameters = try XCTUnwrap(presenterSpy.invokedPresentFetchedLocalMoviesParameters)
//
//        XCTAssertTrue(realmWorkerSpy.invokedFetchMovies)
//        XCTAssertEqual(realmWorkerSpy.invokedFetchMoviesCount, 1)
//        XCTAssertTrue(presenterSpy.invokedPresentFetchedLocalMovies)
//        XCTAssertEqual(presenterSpy.invokedPresentFetchedLocalMoviesCount, 1)
//        XCTAssertEqual(parameters.response.movies, movies)
//        XCTAssertEqual(presenterSpy.invokedPresentFetchedLocalMoviesParametersList.count, 1)
//
//        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
//        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMoviesEmpty)
//        XCTAssertFalse(presenterSpy.invokedPresenterMovieUnfavorite)
//        XCTAssertFalse(presenterSpy.invokedPresentGenericFailure)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
//        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
//    }
//
//    func testFetchLocalMoviesShouldPresentEmptyMovies() {
//        realmWorkerSpy.stubbedFetchMoviesCompletionResult = (.success([]), ())
//        sut.fetchMovies()
//
//        XCTAssertTrue(realmWorkerSpy.invokedFetchMovies)
//        XCTAssertEqual(realmWorkerSpy.invokedFetchMoviesCount, 1)
//        XCTAssertTrue(presenterSpy.invokedPresentFetchedLocalMoviesEmpty)
//        XCTAssertEqual(presenterSpy.invokedPresentFetchedLocalMoviesEmptyCount, 1)
//
//        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
//        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
//        XCTAssertFalse(presenterSpy.invokedPresenterMovieUnfavorite)
//        XCTAssertFalse(presenterSpy.invokedPresentGenericFailure)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
//        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
//    }
//
//    func testFetchLocalMoviesShouldPresentGenericFailure() {
//        realmWorkerSpy.stubbedFetchMoviesCompletionResult = (.failure(.unknown), ())
//        sut.fetchMovies()
//
//        XCTAssertTrue(realmWorkerSpy.invokedFetchMovies)
//        XCTAssertEqual(realmWorkerSpy.invokedFetchMoviesCount, 1)
//        XCTAssertTrue(presenterSpy.invokedPresentGenericFailure)
//        XCTAssertEqual(presenterSpy.invokedPresentGenericFailureCount, 1)
//
//        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
//        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMoviesEmpty)
//        XCTAssertFalse(presenterSpy.invokedPresenterMovieUnfavorite)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
//        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
//    }
//
//    func testFetchLocalMoviesBySearchShouldPresentFetchedMoviesBySearch() throws {
//        let filter = FilterSearch(search: Strings.mockKill.localizable, date: [Strings.mockDate.localizable], genres: ["Action"])
//        let moviesFiltered = try XCTUnwrap(fetchLocalMoviesBySearch(filter: filter))
//
//        XCTAssertTrue(presenterSpy.invokedPresentFetchedMoviesBySearch)
//        XCTAssertEqual(presenterSpy.invokedPresentFetchedMoviesBySearchCount, 1)
//        XCTAssertNotEqual(moviesFiltered, movies)
//        XCTAssertEqual(presenterSpy.invokedPresentFetchedMoviesBySearchParametersList.count, 1)
//
//        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
//        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
//        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMoviesEmpty)
//        XCTAssertFalse(presenterSpy.invokedPresenterMovieUnfavorite)
//        XCTAssertFalse(presenterSpy.invokedPresentGenericFailure)
//        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
//    }
//
//    func testFetchLocalMoviesBySearchWithNoMatchDateFilterPresentFailure() throws {
//        let filter = FilterSearch(date: ["1500"])
//        let moviesFiltered = fetchLocalMoviesBySearch(filter: filter)
//
//        let parameters = try XCTUnwrap(presenterSpy.invokedPresentSearchedMoviesFailureParameters)
//
//        XCTAssertNil(moviesFiltered)
//        XCTAssertTrue(presenterSpy.invokedPresentSearchedMoviesFailure)
//        XCTAssertEqual(presenterSpy.invokedPresentSearchedMoviesFailureCount, 1)
//        XCTAssertFalse(parameters.filter.isEmpty)
//        XCTAssertEqual(parameters.filter.date, filter.date)
//        XCTAssertNil(parameters.filter.genres)
//        XCTAssertNil(parameters.filter.search)
//        XCTAssertEqual(presenterSpy.invokedPresentSearchedMoviesFailureParametersList.count, 1)
//
//        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
//        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
//        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMoviesEmpty)
//        XCTAssertFalse(presenterSpy.invokedPresenterMovieUnfavorite)
//        XCTAssertFalse(presenterSpy.invokedPresentGenericFailure)
//    }
//
//    func testFetchLocalMoviesBySearchWithNoMatchGenresPresentFailure() throws {
//        let filter = FilterSearch(genres: ["Ação"])
//        let moviesFiltered = fetchLocalMoviesBySearch(filter: filter)
//
//        let parameters = try XCTUnwrap(presenterSpy.invokedPresentSearchedMoviesFailureParameters)
//
//        XCTAssertNil(moviesFiltered)
//        XCTAssertTrue(presenterSpy.invokedPresentSearchedMoviesFailure)
//        XCTAssertEqual(presenterSpy.invokedPresentSearchedMoviesFailureCount, 1)
//        XCTAssertFalse(parameters.filter.isEmpty)
//        XCTAssertNil(parameters.filter.date)
//        XCTAssertEqual(parameters.filter.genres, filter.genres)
//        XCTAssertNil(parameters.filter.search)
//        XCTAssertEqual(presenterSpy.invokedPresentSearchedMoviesFailureParametersList.count, 1)
//
//        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
//        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
//        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMoviesEmpty)
//        XCTAssertFalse(presenterSpy.invokedPresenterMovieUnfavorite)
//        XCTAssertFalse(presenterSpy.invokedPresentGenericFailure)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
//    }
//
//    func testFetchLocalMoviesBySearchWithNoMatchSearchPresentFailure() throws {
//        let filter = FilterSearch(search: "aaaaaaaaaa")
//        let moviesFiltered = fetchLocalMoviesBySearch(filter: filter)
//
//        let parameters = try XCTUnwrap(presenterSpy.invokedPresentSearchedMoviesFailureParameters)
//
//        XCTAssertNil(moviesFiltered)
//        XCTAssertTrue(presenterSpy.invokedPresentSearchedMoviesFailure)
//        XCTAssertEqual(presenterSpy.invokedPresentSearchedMoviesFailureCount, 1)
//        XCTAssertFalse(parameters.filter.isEmpty)
//        XCTAssertNil(parameters.filter.date)
//        XCTAssertNil(parameters.filter.genres)
//        XCTAssertEqual(parameters.filter.search, filter.search)
//        XCTAssertEqual(presenterSpy.invokedPresentSearchedMoviesFailureParametersList.count, 1)
//
//        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
//        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
//        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMoviesEmpty)
//        XCTAssertFalse(presenterSpy.invokedPresenterMovieUnfavorite)
//        XCTAssertFalse(presenterSpy.invokedPresentGenericFailure)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
//    }
//
//    func testFetchLocalMoviesByEmptySearchShouldPresentFailure() throws {
//        let filter = FilterSearch()
//        let moviesFiltered = fetchLocalMoviesBySearch(filter: filter)
//
//        XCTAssertTrue(presenterSpy.invokedPresentFetchedMoviesBySearch)
//        XCTAssertEqual(presenterSpy.invokedPresentFetchedMoviesBySearchCount, 1)
//        XCTAssertEqual(moviesFiltered, movies)
//        XCTAssertEqual(presenterSpy.invokedPresentFetchedMoviesBySearchParametersList.count, 1)
//
//        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
//        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
//        XCTAssertFalse(realmWorkerSpy.invokedDeleteMovie)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMoviesEmpty)
//        XCTAssertFalse(presenterSpy.invokedPresenterMovieUnfavorite)
//        XCTAssertFalse(presenterSpy.invokedPresentGenericFailure)
//        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
//    }
//
//    func testDeleteMovieShouldPresentMovieUnfavorite() throws {
//        realmWorkerSpy.stubbedDeleteMovieCompletionResult = (.success(()), ())
//        let request = Favorites.DeleteMovie.Request(movie: movies[0])
//        sut.deleteMovie(request: request)
//
//        let parameters = try XCTUnwrap(realmWorkerSpy.invokedDeleteMovieParameters)
//
//        XCTAssertTrue(realmWorkerSpy.invokedDeleteMovie)
//        XCTAssertEqual(realmWorkerSpy.invokedDeleteMovieCount, 1)
//        XCTAssertEqual(parameters.movie, movies[0])
//        XCTAssertEqual(realmWorkerSpy.invokedDeleteMovieParametersList.count, 1)
//        XCTAssertTrue(presenterSpy.invokedPresenterMovieUnfavorite)
//        XCTAssertEqual(presenterSpy.invokedPresenterMovieUnfavoriteCount, 1)
//
//        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
//        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMoviesEmpty)
//        XCTAssertFalse(presenterSpy.invokedPresentGenericFailure)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
//        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
//    }
//
//    func testDeleteMoviesShouldPresentGenericFailure() throws {
//        realmWorkerSpy.stubbedDeleteMovieCompletionResult = (.failure(.unknown), ())
//        let request = Favorites.DeleteMovie.Request(movie: movies[0])
//        sut.deleteMovie(request: request)
//
//        let parameters = try XCTUnwrap(realmWorkerSpy.invokedDeleteMovieParameters)
//
//        XCTAssertTrue(realmWorkerSpy.invokedDeleteMovie)
//        XCTAssertEqual(realmWorkerSpy.invokedDeleteMovieCount, 1)
//        XCTAssertEqual(parameters.movie, movies[0])
//        XCTAssertEqual(realmWorkerSpy.invokedDeleteMovieParametersList.count, 1)
//        XCTAssertTrue(presenterSpy.invokedPresentGenericFailure)
//        XCTAssertEqual(presenterSpy.invokedPresentGenericFailureCount, 1)
//
//        XCTAssertFalse(realmWorkerSpy.invokedFetchMovies)
//        XCTAssertFalse(realmWorkerSpy.invokedSaveMovie)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMovies)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedLocalMoviesEmpty)
//        XCTAssertFalse(presenterSpy.invokedPresenterMovieUnfavorite)
//        XCTAssertFalse(presenterSpy.invokedPresentFetchedMoviesBySearch)
//        XCTAssertFalse(presenterSpy.invokedPresentSearchedMoviesFailure)
//    }
//
//    // MARK: - Private functions
//
//    private func fetchLocalMoviesBySearch(filter: FilterSearch) -> [Movie]? {
//        let request = Favorites.FetchMoviesBySearch.Request(filter: filter)
//        sut.fetchLocalMoviesBySearch(request: request)
//
//        let movies = presenterSpy.invokedPresentFetchedMoviesBySearchParameters?.response.movies
//
//        return movies
//    }
//}

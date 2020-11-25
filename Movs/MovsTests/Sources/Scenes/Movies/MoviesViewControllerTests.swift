//
//  MoviesViewControllerTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 03/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Fakery
import FBSnapshotTestCase
@testable import Movs

final class MoviesViewControllerTests: FBSnapshotTestCase {
    private lazy var sut: MoviesViewController = {
        let viewController = MoviesViewController(interactor: interactorSpy)
        viewController.delegate = delegateSpy

        return viewController
    }()

    // MARK: - Private constants

    private let interactorSpy = MoviesInteractorSpy()

    private let delegateSpy = MoviesViewControllerDelegateSpy()

    private let faker = Faker(locale: Constants.MovieDefaultParameters.language)

    // MARK: - Override functions

    override func setUp() {
        super.setUp()

        recordMode = false

        setRootViewController(sut)
    }

    override func tearDown() {
        super.tearDown()

        popRootViewController()
        clearRootViewController()
    }

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertFalse(interactorSpy.invokedFetchLocalMovies)
        XCTAssertFalse(interactorSpy.invokedFetchGenres)
        XCTAssertFalse(interactorSpy.invokedFetchMovies)
        XCTAssertFalse(interactorSpy.invokedFetchLocalMoviesBySearch)
        XCTAssertFalse(delegateSpy.invokedGalleryItemTapped)
    }

    func testViewDidLoadShouldCallFetchLocalMovies() {
        //wait viewDidLoad
        wait(for: Constants.Utils.sleep)

        XCTAssertTrue(interactorSpy.invokedFetchLocalMovies)
        XCTAssertEqual(interactorSpy.invokedFetchLocalMoviesCount, 1)
        XCTAssertFalse(interactorSpy.invokedFetchGenres)
        XCTAssertFalse(interactorSpy.invokedFetchMovies)
        XCTAssertFalse(interactorSpy.invokedFetchLocalMoviesBySearch)
        XCTAssertFalse(delegateSpy.invokedGalleryItemTapped)
    }

    func testFetchGenresAfterFetchedLocalMovies() throws {
        let movies = Movies.FetchLocalMovies.ViewModel(movies: MocksHelper.getRandomMovies())
        sut.onFetchedLocalMovies(viewModel: movies)

        let parameters = try XCTUnwrap(interactorSpy.invokedFetchGenresParameters)

        XCTAssertTrue(interactorSpy.invokedFetchGenres)
        XCTAssertEqual(interactorSpy.invokedFetchGenresCount, 1)
        XCTAssertEqual(parameters.request.language, Constants.MovieDefaultParameters.language)
        XCTAssertEqual(interactorSpy.invokedFetchGenresParametersList.count, 1)

        XCTAssertFalse(interactorSpy.invokedFetchLocalMovies)
        XCTAssertFalse(interactorSpy.invokedFetchMovies)
        XCTAssertFalse(interactorSpy.invokedFetchLocalMoviesBySearch)
        XCTAssertFalse(delegateSpy.invokedGalleryItemTapped)
    }

    func testFetchMoviesAfterFetchedGenres() throws {
        let genres = GenresResponse(path: JSONMocks.genresResponse.rawValue).genres
        let viewModel = Movies.FetchGenres.ViewModel(genres: genres)
        sut.onFetchedGenres(viewModel: viewModel)

        let parameters = try XCTUnwrap(interactorSpy.invokedFetchMoviesParameters)

        XCTAssertTrue(interactorSpy.invokedFetchMovies)
        XCTAssertEqual(interactorSpy.invokedFetchMoviesCount, 1)
        XCTAssertEqual(parameters.request.language, Constants.MovieDefaultParameters.language)
        XCTAssertEqual(parameters.request.page, Constants.MovieDefaultParameters.page)
        XCTAssertEqual(parameters.request.genres.count, genres.count)
        XCTAssertEqual(interactorSpy.invokedFetchMoviesParametersList.count, 1)

        XCTAssertFalse(interactorSpy.invokedFetchGenres)
        XCTAssertFalse(interactorSpy.invokedFetchLocalMovies)
        XCTAssertFalse(interactorSpy.invokedFetchLocalMoviesBySearch)
        XCTAssertFalse(delegateSpy.invokedGalleryItemTapped)
    }

    func testShouldDisplayMoviesAfterFetchedMovies() {
        // waiting to start loading
        wait(for: 1)
        XCTAssertTrue(sut.view.hasLoading())
        verify(sut, identifier: "loading")

        let viewModel = Movies.FetchMovies.ViewModel(page: 1, totalPages: 10, movies: MocksHelper.getMockedMovies())
        sut.displayMovies(viewModel: viewModel)
        sut.view.layoutIfNeeded()

        // waiting to load images
        wait()

        XCTAssertFalse(sut.view.hasLoading())
        verify(sut)
    }

    func testShouldDisplayGenericError() {
        sut.displayGenericError()

        verify(sut)
    }

    func testShouldDisplayMoviesBySearch() {
        let viewModel = Movies.FetchMoviesBySearch.ViewModel(movies: MocksHelper.getMockedMovies())
        sut.displayMoviesBySearch(viewModel: viewModel)
        sut.view.layoutIfNeeded()

        // waiting to load images
        wait()

        verify(sut)
    }

    func testShouldDisplaySearchError() {
        let search = Strings.mockDog.localizable
        sut.displaySearchError(searchedText: search)

        verify(sut)
    }

    func testDisplayGenericErrorAfterFetchMovies() {
        let genres = GenresResponse(path: JSONMocks.genresResponse.rawValue).genres
        sut.displayGenericError()

        let viewModel = Movies.FetchGenres.ViewModel(genres: genres)
        sut.onFetchedGenres(viewModel: viewModel)

        verify(sut)
    }

    func testShouldFilterWithSearch() throws {
        let search = Strings.mockDog.localizable
        sut.filter(search: search)

        let parameters = try XCTUnwrap(interactorSpy.invokedFetchLocalMoviesBySearchParameters)

        XCTAssertTrue(interactorSpy.invokedFetchLocalMoviesBySearch)
        XCTAssertEqual(interactorSpy.invokedFetchLocalMoviesBySearchCount, 1)
        XCTAssertEqual(parameters.request.movies.count, 0)
        XCTAssertEqual(parameters.request.filter, search)
        XCTAssertEqual(interactorSpy.invokedFetchLocalMoviesBySearchParametersList.count, 1)

        XCTAssertFalse(interactorSpy.invokedFetchMovies)
        XCTAssertFalse(interactorSpy.invokedFetchGenres)
        XCTAssertFalse(interactorSpy.invokedFetchLocalMovies)
        XCTAssertFalse(delegateSpy.invokedGalleryItemTapped)
    }

    func testShouldFilterSearchEmpty() {
        sut.filter(search: .empty)

        XCTAssertTrue(interactorSpy.invokedFetchLocalMovies)
        XCTAssertEqual(interactorSpy.invokedFetchLocalMoviesCount, 1)
        XCTAssertFalse(interactorSpy.invokedFetchGenres)
        XCTAssertFalse(interactorSpy.invokedFetchMovies)
        XCTAssertFalse(interactorSpy.invokedFetchLocalMoviesBySearch)
        XCTAssertFalse(delegateSpy.invokedGalleryItemTapped)
    }
}

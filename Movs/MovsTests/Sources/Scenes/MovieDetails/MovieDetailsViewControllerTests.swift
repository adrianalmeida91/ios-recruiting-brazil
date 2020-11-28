//
//  MovieDetailsViewControllerTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 19/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs

final class MovieDetailsViewControllerTests: FBSnapshotTestCase {
    private lazy var sut = MovieDetailsViewController(movie: movieDetails, interactor: interactorSpy)

    // MARK: - Private constants

    private let movieDetails = MocksHelper.getMockedMovie()

    private let interactorSpy = MovieDetailsInteractorSpy()

    // MARK: - Override functions

    override func setUp() {
        super.setUp()

        recordMode = false

        setRootViewController(sut)
    }

    override func tearDown() {
        super.tearDown()

        movieDetails.isFavorite = false

        popRootViewController()
        clearRootViewController()
    }

    // MARK: - Test functions

    func testInitializationWithMovieUnfavorite() {
        _ = sut

        verifyAllFalseState()
    }

    func testInitializationWithMovieFavorite() throws {
        movieDetails.isFavorite = true
        _ = MovieDetailsViewController(movie: movieDetails, interactor: interactorSpy)

        let parameters = try XCTUnwrap(interactorSpy.invokedFetchMovieParameters)

        XCTAssertTrue(interactorSpy.invokedFetchMovie)
        XCTAssertEqual(interactorSpy.invokedFetchMovieCount, 1)
        XCTAssertEqual(parameters.request.id, movieDetails.id)
        XCTAssertEqual(interactorSpy.invokedFetchMovieParametersList.count, 1)

        XCTAssertFalse(interactorSpy.invokedSaveMovie)
        XCTAssertFalse(interactorSpy.invokedDeleteMovie)
    }


    func testViewControllerShouldDisplayMovie() {
        let viewModel = MovieDetails.FetchMovie.ViewModel(movie: movieDetails)
        sut.displayMovie(viewModel: viewModel)

        verifyAllFalseState()
    }

    func testViewControllerShouldDisplayFavoriteIcon() {
        sut.displayFavoriteIcon()

        verifyAllFalseState()
        verify(sut)
    }

    func testViewControllerShouldDisplayUnfavoriteIcon() {
        sut.displayUnfavoriteIcon()

        verifyAllFalseState()
        verify(sut)
    }

    // MARK: - Private functions

    private func verifyAllFalseState() {
        XCTAssertFalse(interactorSpy.invokedFetchMovie)
        XCTAssertFalse(interactorSpy.invokedSaveMovie)
        XCTAssertFalse(interactorSpy.invokedDeleteMovie)
    }
}

//
//  MovieDetailsPresenterTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 19/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class MovieDetailsPresenterTests: XCTestCase {
    private lazy var sut: MovieDetailsPresenter = {
        let presenter = MovieDetailsPresenter()
        presenter.viewController = displaySpy

        return presenter
    }()

    // MARK: - Private constants

    private let displaySpy = MovieDetailsDisplaySpy()

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertFalse(displaySpy.invokedDisplayMovie)
        XCTAssertFalse(displaySpy.invokedDisplayFavoriteIcon)
        XCTAssertFalse(displaySpy.invokedDisplayUnfavoriteIcon)
    }

    func testPresentFetchedMovieShouldDisplayMovie() throws {
        let movie = MocksHelper.getMovie()
        let response = MovieDetails.FetchMovie.Response(movie: movie)
        sut.presentFetchedMovie(response: response)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplayMovieParameters)

        XCTAssertTrue(displaySpy.invokedDisplayMovie)
        XCTAssertEqual(displaySpy.invokedDisplayMovieCount, 1)
        XCTAssertEqual(parameters.viewModel.movie, movie)
        XCTAssertEqual(displaySpy.invokedDisplayMovieParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedDisplayFavoriteIcon)
        XCTAssertFalse(displaySpy.invokedDisplayUnfavoriteIcon)
    }

    func testSaveMovieSuccessfulShouldDisplayFavoriteIcon() {
        sut.onSaveMovieSuccessful()

        validateFavoriteIcon()
    }

    func testSaveMovieFailureShouldDisplayUnfavoriteIcon() {
        sut.onSaveMovieFailure()

        validateUnfavoriteIcon()
    }

    func testDeleteMovieSuccessfulShouldDisplayUnfavoriteIcon() {
        sut.onDeleteMovieSuccessful()

        validateUnfavoriteIcon()
    }

    func testDeleteMovieFailureShouldDisplayFavoriteIcon() {
        sut.onDeleteMovieFailure()

        validateFavoriteIcon()
    }

    // MARK: - Private functions

    private func validateFavoriteIcon() {
        XCTAssertTrue(displaySpy.invokedDisplayFavoriteIcon)
        XCTAssertEqual(displaySpy.invokedDisplayFavoriteIconCount, 1)

        XCTAssertFalse(displaySpy.invokedDisplayMovie)
        XCTAssertFalse(displaySpy.invokedDisplayUnfavoriteIcon)
    }

    private func validateUnfavoriteIcon() {
        XCTAssertTrue(displaySpy.invokedDisplayUnfavoriteIcon)
        XCTAssertEqual(displaySpy.invokedDisplayUnfavoriteIconCount, 1)

        XCTAssertFalse(displaySpy.invokedDisplayMovie)
        XCTAssertFalse(displaySpy.invokedDisplayFavoriteIcon)
    }
}

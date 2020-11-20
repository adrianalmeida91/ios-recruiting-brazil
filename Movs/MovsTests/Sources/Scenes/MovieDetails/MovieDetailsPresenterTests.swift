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

        XCTAssertFalse(displaySpy.invokedDisplayFavoriteIcon)
        XCTAssertFalse(displaySpy.invokedDisplayUnfavoriteIcon)
    }

    func testOnSaveMovieShouldDisplayFavoriteIcon() {
        sut.onSaveMovieSuccessful()

        XCTAssertTrue(displaySpy.invokedDisplayFavoriteIcon)
        XCTAssertFalse(displaySpy.invokedDisplayUnfavoriteIcon)
    }

    func testOnSaveMovieFailureShouldDisplayUnfavoriteIcon() {
        sut.onSaveMovieFailure()

        XCTAssertFalse(displaySpy.invokedDisplayFavoriteIcon)
        XCTAssertTrue(displaySpy.invokedDisplayUnfavoriteIcon)
    }

    func testOnDeleteMovieShouldDisplayUnfavoriteIcon() {
        sut.onDeleteMovieSuccessful()

        XCTAssertFalse(displaySpy.invokedDisplayFavoriteIcon)
        XCTAssertTrue(displaySpy.invokedDisplayUnfavoriteIcon)
    }

    func testOnDeleteMovieFailureShouldDisplayFavoriteIcon() {
        sut.onDeleteMovieFailure()

        XCTAssertTrue(displaySpy.invokedDisplayFavoriteIcon)
        XCTAssertFalse(displaySpy.invokedDisplayUnfavoriteIcon)
    }
}

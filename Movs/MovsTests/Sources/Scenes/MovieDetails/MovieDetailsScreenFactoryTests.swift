//
//  MovieDetailsScreenFactoryTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class MovieDetailsScreenFactoryTests: XCTestCase {
    private lazy var sut = MovieDetailsScreenFactory.make(movie: movie)

    // MARK: - Private constants

    private let movie = MocksHelper.getMockedMovie()

    // MARK: - Test functions

    func testShouldCreateMovieDetailsViewControllerByFactory() {
        _ = sut

        XCTAssertNotNil(sut)
    }
}

//
//  MovieRealmDbServiceTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 04/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class MovieRealmDbServiceTests: XCTestCase {
    private lazy var sut = MovieRealmDbService()

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertNotNil(sut)
    }

    func testMoviesRealmDbServiceShouldFetchMovies() throws {
        let completionExpectation = expectation(description: #function)

        var movies: [Movie] = []

        sut.fetch(Movie.self) { result in
            defer {
                completionExpectation.fulfill()
            }

            do {
                let givenResult = try result.get()
                movies = givenResult
            } catch {
                debugPrint(error)
                XCTFail()
            }
        }

        wait(for: [completionExpectation], timeout: 1)

        XCTAssertGreaterThanOrEqual(movies.count, 0)
    }
}

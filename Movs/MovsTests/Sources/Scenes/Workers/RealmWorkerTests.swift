//
//  RealmWorkerTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 04/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class RealmWorkerTests: XCTestCase {
    private lazy var sut = RealmWorker(provider: provider)

    // MARK: - Private constants

    private let provider = MovieRealmDbService()

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertNotNil(sut)
    }

    func testWorkerShouldFetchMovies() {
        let completionExpectation = expectation(description: #function)

        var movies: [Movie] = []

        sut.fetchMovies() { result in
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

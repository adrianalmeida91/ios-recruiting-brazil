//
//  MovieDbAPITests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 04/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
import Moya
@testable import Movs

final class MovieDbAPITests: XCTestCase {
    private let baseUrl = URL(string: "https://api.themoviedb.org/3")

    private let headers = ["Content-Type": "application/json"]

    // MARK: - Test functions

    func testMovieDbAPIFetchGenresParameters() {
        let sut = MovieDbAPI.fetchGenres(language: Constants.MovieDefaultParameters.language)

        XCTAssertEqual(sut.baseURL, baseUrl)
        XCTAssertEqual(sut.path, "/genre/movie/list")
        XCTAssertEqual(sut.method, .get)
        XCTAssertNotNil(sut.sampleData)
        XCTAssertNotNil(sut.task)
        XCTAssertEqual(sut.headers, headers)
    }

    func testMovieDbAPIFetchMoviesParameters() {
        let sut = MovieDbAPI.fetchMovies(language: Constants.MovieDefaultParameters.language, page: Constants.MovieDefaultParameters.page)

        XCTAssertEqual(sut.baseURL, baseUrl)
        XCTAssertEqual(sut.path, "/movie/popular")
        XCTAssertEqual(sut.method, .get)
        XCTAssertNotNil(sut.sampleData)
        XCTAssertNotNil(sut.task)
        XCTAssertEqual(sut.headers, headers)
    }
}

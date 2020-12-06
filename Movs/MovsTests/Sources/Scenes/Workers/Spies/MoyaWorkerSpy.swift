//
//  MoyaWorkerSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 08/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class MoyaWorkerSpy: MoyaWorkerProtocol {
    private(set) var invokedFetchGenres = false
    private(set) var invokedFetchGenresCount = 0
    private(set) var invokedFetchGenresParameters: (language: String, Void)?
    private(set) var invokedFetchGenresParametersList = [(language: String, Void)]()
    var stubbedFetchGenresCompletionResult: (Result<GenresResponse, Error>, Void)?

    private(set) var invokedFetchMovies = false
    private(set) var invokedFetchMoviesCount = 0
    private(set) var invokedFetchMoviesParameters: (language: String, page: Int)?
    private(set) var invokedFetchMoviesParametersList = [(language: String, page: Int)]()
    var stubbedFetchMoviesCompletionResult: (Result<MoviesPopulariesResponse, Error>, Void)?

    // MARK: - MoyaWorkerProtocol conforms

    func fetchGenres(language: String, completion: @escaping (Result<GenresResponse, Error>) -> Void) {
        invokedFetchGenres = true
        invokedFetchGenresCount += 1
        invokedFetchGenresParameters = (language, ())
        invokedFetchGenresParametersList.append((language, ()))
        if let result = stubbedFetchGenresCompletionResult {
            completion(result.0)
        }
    }

    func fetchMovies(language: String, page: Int, completion: @escaping (Result<MoviesPopulariesResponse, Error>) -> Void) {
        invokedFetchMovies = true
        invokedFetchMoviesCount += 1
        invokedFetchMoviesParameters = (language, page)
        invokedFetchMoviesParametersList.append((language, page))
        if let result = stubbedFetchMoviesCompletionResult {
            completion(result.0)
        }
    }
}

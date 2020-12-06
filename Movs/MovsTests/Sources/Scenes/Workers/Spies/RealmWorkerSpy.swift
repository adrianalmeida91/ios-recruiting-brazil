//
//  RealmWorkerSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 08/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class RealmWorkerSpy: RealmWorkerProtocol {
    private(set) var invokedFetchMovies = false
    private(set) var invokedFetchMoviesCount = 0
    var stubbedFetchMoviesCompletionResult: (Result<[Movie], Error>, Void)?

    private(set) var invokedSaveMovie = false
    private(set) var invokedSaveMovieCount = 0
    private(set) var invokedSaveMovieParameters: (movie: Movie, Void)?
    private(set) var invokedSaveMovieParametersList = [(movie: Movie, Void)]()
    var stubbedSaveMovieCompletionResult: (Result<Void, Error>, Void)?

    private(set) var invokedDeleteMovie = false
    private(set) var invokedDeleteMovieCount = 0
    private(set) var invokedDeleteMovieParameters: (movie: Movie, Void)?
    private(set) var invokedDeleteMovieParametersList = [(movie: Movie, Void)]()
    var stubbedDeleteMovieCompletionResult: (Result<Void, Error>, Void)?

    // MARK: - RealmWorkerProtocol conforms

    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        invokedFetchMovies = true
        invokedFetchMoviesCount += 1
        if let result = stubbedFetchMoviesCompletionResult {
            completion(result.0)
        }
    }

    func saveMovie(movie: Movie, completion: @escaping (Result<Void, Error>) -> Void) {
        invokedSaveMovie = true
        invokedSaveMovieCount += 1
        invokedSaveMovieParameters = (movie, ())
        invokedSaveMovieParametersList.append((movie, ()))
        if let result = stubbedSaveMovieCompletionResult {
            completion(result.0)
        }
    }

    func deleteMovie(movie: Movie, completion: @escaping (Result<Void, Error>) -> Void) {
        invokedDeleteMovie = true
        invokedDeleteMovieCount += 1
        invokedDeleteMovieParameters = (movie, ())
        invokedDeleteMovieParametersList.append((movie, ()))
        if let result = stubbedDeleteMovieCompletionResult {
            completion(result.0)
        }
    }
}

//
//  MoviesMoyaWorker.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Moya

protocol MoviesMoyaWorkerProtocol: AnyObject {
    func fetchGenres(language: String, completion: @escaping (Result<GenresResponse, NetworkError>) -> Void)
    func fetchMovies(language: String, page: Int, completion: @escaping (Result<MoviesPopulariesResponse, NetworkError>) -> Void)
}

final class MoviesMoyaWorker: MoviesMoyaWorkerProtocol {
    private let provider: MoyaProvider<MovieDbAPI>

    // MARK: - Initializers

    init(provider: MoyaProvider<MovieDbAPI>) {
        self.provider = provider
    }

    // MARK: - Conforms MoviesWorkerProtocol

    func fetchGenres(language: String, completion: @escaping (Result<GenresResponse, NetworkError>) -> Void) {
        provider.request(.fetchGenres(language: language), completion: completion)
    }

    func fetchMovies(language: String, page: Int, completion: @escaping (Result<MoviesPopulariesResponse, NetworkError>) -> Void) {
        provider.request(.fetchMovies(language: language, page: page), completion: completion)
    }
}

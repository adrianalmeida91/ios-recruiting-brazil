//
//  MoviesMoyaWorker.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Moya

protocol MoyaWorkerProtocol: AnyObject {
    func fetchGenres(language: String, completion: @escaping (Result<GenresResponse, Error>) -> Void)
    func fetchMovies(language: String, page: Int, completion: @escaping (Result<MoviesPopulariesResponse, Error>) -> Void)
}

final class MoyaWorker: MoyaWorkerProtocol {
    private let provider: MoyaProvider<MovieDbAPI>

    // MARK: - Initializers

    init(provider: MoyaProvider<MovieDbAPI>) {
        self.provider = provider
    }

    // MARK: - Conforms MoviesWorkerProtocol

    func fetchGenres(language: String, completion: @escaping (Result<GenresResponse, Error>) -> Void) {
        provider.request(.fetchGenres(language: language), completion: completion)
    }

    func fetchMovies(language: String, page: Int, completion: @escaping (Result<MoviesPopulariesResponse, Error>) -> Void) {
        provider.request(.fetchMovies(language: language, page: page), completion: completion)
    }
}

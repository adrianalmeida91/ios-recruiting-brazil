//
//  MoviesWorkerProtocol.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MoviesWorkerProtocol: AnyObject {
    func fetchGenres(language: String, completion: @escaping (Result<GenresResponse, NetworkError>) -> Void)
    func fetchMovies(language: String, page: Int, completion: @escaping (Result<MoviesPopulariesResponse, NetworkError>) -> Void)
}

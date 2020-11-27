//
//  MovieDetailsInteractorSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 19/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class MovieDetailsInteractorSpy: MovieDetailsBusinessLogic {
    private(set) var invokedFetchMovie = false
    private(set) var invokedFetchMovieCount = 0
    private(set) var invokedFetchMovieParameters: (request: MovieDetails.FetchMovie.Request, Void)?
    private(set) var invokedFetchMovieParametersList = [(request: MovieDetails.FetchMovie.Request, Void)]()

    private(set) var invokedSaveMovie = false
    private(set) var invokedSaveMovieCount = 0
    private(set) var invokedSaveMovieParameters: (request: MovieDetails.SaveMovie.Request, Void)?
    private(set) var invokedSaveMovieParametersList = [(request: MovieDetails.SaveMovie.Request, Void)]()

    private(set) var invokedDeleteMovie = false
    private(set) var invokedDeleteMovieCount = 0
    private(set) var invokedDeleteMovieParameters: (request: MovieDetails.DeleteMovie.Request, Void)?
    private(set) var invokedDeleteMovieParametersList = [(request: MovieDetails.DeleteMovie.Request, Void)]()

    // MARK: - MovieDetailsBusinessLogic conforms

    func fetchMovie(request: MovieDetails.FetchMovie.Request) {
        invokedFetchMovie = true
        invokedFetchMovieCount += 1
        invokedFetchMovieParameters = (request, ())
        invokedFetchMovieParametersList.append((request, ()))
    }

    func saveMovie(request: MovieDetails.SaveMovie.Request) {
        invokedSaveMovie = true
        invokedSaveMovieCount += 1
        invokedSaveMovieParameters = (request, ())
        invokedSaveMovieParametersList.append((request, ()))
    }

    func deleteMovie(request: MovieDetails.DeleteMovie.Request) {
        invokedDeleteMovie = true
        invokedDeleteMovieCount += 1
        invokedDeleteMovieParameters = (request, ())
        invokedDeleteMovieParametersList.append((request, ()))
    }
}

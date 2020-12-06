//
//  MocksHelper.swift
//  MovsTests
//
//  Created by Adrian Almeida on 06/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Fakery
import UIKit
@testable import Movs

final class MocksHelper {
    enum Error: Swift.Error {
        case test
    }

    enum Genres: String, CaseIterable {
        case action = "Action"
        case comedy = "Comedy"
        case animation = "Animation"
    }

    enum Dates: String, CaseIterable {
        case y2020 = "2020"
        case y2019 = "2019"
        case y2018 = "2018"
    }

    enum Strings: String {
        case title = "Dog"
        case otherTitle = "Other dog"
        case search = "KILL"
        case searchError = "aaaaaaaaaa"
        case genreError = "Accctiiiiooonnnn"
        case dateError = "2012132032"
        case overview = "O trabalho do bilionário CEO de tecnologia Donovan Chalmers (Willis) é tão valioso que ele contrata mercenários para protegê-lo e um grupo terrorista sequestra sua filha apenas para obtê-lo."
        case serverError = "Server error"
        case communicationError = "Communication error"
        case newCommunicationError = "New communication error"
    }

    static func getGenres() -> [String] {
        return Genres.allCases.map { $0.rawValue }
    }

    static func getDates() -> [String] {
        return Dates.allCases.map { $0.rawValue }
    }

    static func getMovie() -> Movie {
        let movieResponse = MovieResponse(path: JSONMocks.movieResponse.rawValue)

        return Movie(id: movieResponse.id, title: movieResponse.title, imageURL: .empty, genres: MocksHelper.Genres.action.rawValue, releaseDate: movieResponse.releaseDate.year, overview: movieResponse.overview, isFavorite: false)
    }

    static func getMovies() -> [Movie] {
        let moviesPopulariesResponse = MoviesPopulariesResponse(path: JSONMocks.moviesPopulariesResponse.rawValue)

        return moviesPopulariesResponse.moviesResponse.map { movieResponse -> Movie in
            Movie(id: movieResponse.id, title: movieResponse.title, imageURL: .empty, genres: MocksHelper.Genres.action.rawValue, releaseDate: movieResponse.releaseDate.year, overview: movieResponse.overview, isFavorite: false)
        }
    }

    static func getRandomMovies() -> [Movie] {
        let genresResponse = GenresResponse(path: JSONMocks.genresResponse.rawValue)

        let faker = Faker(locale: Constants.MovieDefaultParameters.language)

        var movies: [Movie] = []
        var id = 0
        let randomMoviesCount = Int.random(in: 6...30)

        for _ in 0...randomMoviesCount {
            id += 1
            let title = faker.lorem.word()
            let image = faker.internet.image()

            var genres: [String] = []
            let randomGenresCount = Int.random(in: 0...3)
            for _ in 0...randomGenresCount {
                let randomGenreIndex = Int.random(in: 0...genresResponse.genres.count - 1)
                genres.append(genresResponse.genres[randomGenreIndex].name)
            }
            let genresLabel = genres.count > 0 ? genres.joined(separator: Constants.Utils.genresSeparator) : nil

            let fakeDate = faker.business.creditCardExpiryDate()?.toString.year
            let releaseDate = fakeDate ?? MocksHelper.Dates.y2020.rawValue

            let overview = faker.lorem.sentences()

            let isFavorites = Bool.random()

            movies.append(Movie(id: id, title: title, imageURL: image, genres: genresLabel, releaseDate: releaseDate, overview: overview, isFavorite: isFavorites))
        }

        return movies
    }
}

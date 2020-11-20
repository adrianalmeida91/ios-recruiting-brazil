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
    static func getMockedMovie() -> Movie {
        let movieResponse = MovieResponse(path: JSONMocks.movieResponse.rawValue)

        return Movie(id: movieResponse.id, title: movieResponse.title, imageURL: Constants.MovieNetwork.baseImageURL.appending(movieResponse.imageURL), genres: Strings.mockGenres.localizable, releaseDate: movieResponse.releaseDate.year, overview: movieResponse.overview, isFavorite: false)
    }

    static func getMockedMovies() -> [Movie] {
        let moviesPopulariesResponse = MoviesPopulariesResponse(path: JSONMocks.moviesPopulariesResponse.rawValue)

        return moviesPopulariesResponse.moviesResponse.map { movieResponse -> Movie in
            Movie(id: movieResponse.id, title: movieResponse.title, imageURL: Constants.MovieNetwork.baseImageURL.appending(movieResponse.imageURL), genres: Strings.mockGenres.localizable, releaseDate: movieResponse.releaseDate.year, overview: movieResponse.overview, isFavorite: false)
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
            let releaseDate = fakeDate ?? Strings.mockDate.localizable

            let overview = faker.lorem.sentences()

            let isFavorites = Bool.random()

            movies.append(Movie(id: id, title: title, imageURL: image, genres: genresLabel, releaseDate: releaseDate, overview: overview, isFavorite: isFavorites))
        }

        return movies
    }
}

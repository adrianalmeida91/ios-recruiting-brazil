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
    static func readLocalFile(forName name: String, ofType type: String = "json") -> Data? {
        do {
            if let bundlePath = Bundle(for: MocksHelper.self).path(forResource: name, ofType: type),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error.localizedDescription)
        }

        return nil
    }

    static func parse<T: Decodable>(jsonData: Data) -> T? {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: jsonData)

            return decodedData
        } catch {
            print(error.localizedDescription)
        }

        return nil
    }

    static func getResponse<T: Decodable>() -> T? {
        guard let localData = readLocalFile(forName: String(describing: T.self)),
            let response: T = parse(jsonData: localData) else {
                return nil
        }

        return response
    }

    // MARK: - Mocks generator

    static func getMockedGenres() -> GenresResponse? {
        guard let genresResponse: GenresResponse = getResponse() else {
            return nil
        }

        return genresResponse
    }

    static func getMockedMoviesPopulariesResponse() -> MoviesPopulariesResponse? {
        guard let moviesPopulariesResponse: MoviesPopulariesResponse = getResponse() else {
            return nil
        }

        return moviesPopulariesResponse
    }

    static func getMockedMovies() -> [Movie] {
        guard let moviesPopulariesResponse = getMockedMoviesPopulariesResponse() else {
            return []
        }

        return moviesPopulariesResponse.moviesResponse.map { movieResponse -> Movie in
            Movie(id: movieResponse.id, title: movieResponse.title, imageURL: Constants.MovieNetwork.baseImageURL.appending(movieResponse.imageURL), genres: Strings.mockGenres.localizable, releaseDate: movieResponse.releaseDate.year, overview: movieResponse.overview, isFavorite: false)
        }
    }

    static func getRandomMovies() -> [Movie] {
        guard let genresResponse = getMockedGenres() else {
            return []
        }

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

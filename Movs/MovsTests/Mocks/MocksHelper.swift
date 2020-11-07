//
//  MocksHelper.swift
//  MovsTests
//
//  Created by Adrian Almeida on 06/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

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

//    static func getMoviesPopulariesResponse() -> MoviesPopulariesResponse? {
//        guard let localData = readLocalFile(forName: String(describing: MoviesPopulariesResponse.self)),
//            let moviesPopulariesResponse: MoviesPopulariesResponse = parse(jsonData: localData) else {
//                return nil
//        }
//
//        return moviesPopulariesResponse
//    }
//
//    static func getMovieResponse() -> MovieResponse? {
//        guard let localData = readLocalFile(forName: String(describing: MovieResponse.self)),
//            let movieResponse: MovieResponse = parse(jsonData: localData) else {
//                return nil
//        }
//
//        return movieResponse
//    }

    static func getResponse<T: Decodable>() -> T? {
        guard let localData = readLocalFile(forName: String(describing: T.self)),
            let response: T = parse(jsonData: localData) else {
                return nil
        }

        return response
    }
}

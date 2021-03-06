//
//  MoviesModels.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

enum Movies {
    enum FetchMovies {
        struct Request {
            let language: String
            let page: Int
        }

        struct Response {
            let page: Int
            let totalPages: Int
            let movies: [Movie]
        }

        struct ViewModel {
            let page: Int
            let totalPages: Int
            let movies: [Movie]
        }
    }

    enum FetchMoviesBySearch {
        struct Request {
            let filter: String
        }

        struct Response {
            let movies: [Movie]
        }

        struct ViewModel {
            let movies: [Movie]
        }
    }
}

//
//  MovieDetailsModels.swift
//  Movs
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

enum MovieDetails {
    enum FetchMovie {
        struct Request {
            let id: Int
        }

        struct Response {
            let movie: Movie
        }

        struct ViewModel {
            let movie: Movie
        }
    }

    enum SaveMovie {
        struct Request {
            let movie: Movie
        }
    }

    enum DeleteMovie {
        struct Request {
            let movie: Movie
        }
    }
}

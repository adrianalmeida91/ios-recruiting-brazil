//
//  MovieDetailsModels.swift
//  Movs
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

enum MovieDetails {
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

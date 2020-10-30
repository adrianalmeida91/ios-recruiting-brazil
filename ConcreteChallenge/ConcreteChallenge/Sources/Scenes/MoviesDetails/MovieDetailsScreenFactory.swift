//
//  MovieDetailsScreenFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum MovieDetailsScreenFactory {
    static func makeMoviesDetails(movie: Movie) -> UIViewController {
        let movieDetailsViewController = MovieDetailsViewController(movie: movie)

        return movieDetailsViewController
    }
}

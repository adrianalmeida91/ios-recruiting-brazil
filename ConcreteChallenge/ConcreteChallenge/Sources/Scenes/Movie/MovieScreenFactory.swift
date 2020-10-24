//
//  MovieScreenFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum MovieScreenFactory {
    static func makeMovie() -> UIViewController {
        let movieViewController = MovieViewController()

        return movieViewController
    }
}

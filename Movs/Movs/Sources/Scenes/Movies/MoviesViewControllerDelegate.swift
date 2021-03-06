//
//  MoviesViewControllerDelegate.swift
//  Movs
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MoviesViewControllerDelegate: AnyObject {
    func galleryItemTapped(movie: Movie, _ viewController: MoviesViewController)
}

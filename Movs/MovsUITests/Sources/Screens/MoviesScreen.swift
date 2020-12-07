//
//  MoviesScreen.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 06/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class MoviesScreen: ScreenTest {
    private lazy var buttonsElements = findAll(.button)
    private lazy var views = findAll(.other)

    // MARK: - Lazy variables

    lazy var moviesTabBarItem = buttonsElements[MoviesIdentifiers.moviesTabBarItem.identifier]
    lazy var favoritesTabBarItem = buttonsElements[FavoritesIdentifiers.favoritesTabBarItem.identifier]
    lazy var galleryItems = views.matching(identifier: ComponentsIdentifiers.gridGalleryItemView.identifier)

    // MARK: - Initializer

    init() {
        waitForExpectation(element: moviesTabBarItem, timeout: timeout)
    }

    // MARK: - Functions

    @discardableResult
    func galleryItemIndexTap(at index: Int) -> MovieDetails {
        let galleryItem = galleryItems.element(boundBy: index)
        galleryItem.tap()

        return MovieDetails()
    }
}

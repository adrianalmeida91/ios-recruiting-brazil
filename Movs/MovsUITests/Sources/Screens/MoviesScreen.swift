//
//  MoviesScreen.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 06/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class MoviesScreen: ScreenTest {
    private lazy var searchFieldElements = findAll(.searchField)
    private lazy var viewElements = findAll(.other)
    private lazy var imageElements = findAll(.image)
    private lazy var staticTextElements = findAll(.staticText)
    private lazy var buttonElements = findAll(.button)

    // MARK: - Lazy variables

    lazy var searchField = searchFieldElements["Search"]
    lazy var cancelSearchButton = buttonElements["Cancel"]
    lazy var galleryItem = viewElements[ComponentsIdentifiers.gridGalleryItemView.identifier]
    lazy var galleryItems = viewElements.matching(identifier: ComponentsIdentifiers.gridGalleryItemView.identifier)
    lazy var moviesTabBarItem = buttonElements[MoviesIdentifiers.moviesTabBarItem.identifier]
    lazy var favoritesTabBarItem = buttonElements[FavoritesIdentifiers.favoritesTabBarItem.identifier]

    // MARK: - Initializer

    init() {
        waitForExpectation(element: galleryItem, timeout: timeout)
    }

    // MARK: - Functions

    @discardableResult
    func searchText(text: String) -> MoviesScreen {
        sendText(element: searchField, text: text)

        return self
    }

    @discardableResult
    func clearSearchText() -> MoviesScreen {
        searchField.clearText()

        return self
    }

    @discardableResult
    func cancelSearchButtonTap() -> MoviesScreen {
        cancelSearchButton.tap()

        return self
    }

    @discardableResult
    func galleryItemIndexTap(at index: Int) -> MovieDetailsScreen {
        let galleryItem = galleryItems.element(boundBy: index)
        galleryItem.tap()

        return MovieDetailsScreen()
    }

    @discardableResult
    func favoriteIconTap() -> FavoritesScreen {
        favoritesTabBarItem.tap()

        return FavoritesScreen()
    }

    func verifyErrorMessage(text: String) -> Bool {
        let searchIcon = imageElements["search_icon"]
        let staticText = staticTextElements["Search by \"\(text)\" has no result"]

        return searchIcon.waitForExistence(timeout: timeout) && staticText.waitForExistence(timeout: timeout)
    }
}

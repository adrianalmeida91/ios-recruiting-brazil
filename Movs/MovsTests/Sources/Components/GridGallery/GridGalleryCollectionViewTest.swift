//
//  GridGalleryCollectionViewTest.swift
//  MovsTests
//
//  Created by Adrian Almeida on 06/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs

final class GridGalleryCollectionViewTest: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()

        recordMode = false
    }

    // MARK: - Private constants

    private let itemSize = CGSize(width: 160, height: 200)

    // MARK: - Test functions

    func testShouldShowGalleryCollectionView() {
        let sut = GridGalleryCollectionView(itemSize: itemSize, items: getItems())
        addGridGalleryLayout(galleryCollectionView: sut)

        wait(for: Constants.Utils.sleep)

        verify(sut)
    }

    func testShouldUpdateWithFavoriteGalleryCollectionView() {
        let sut = GridGalleryCollectionView(itemSize: itemSize, items: getItems())
        addGridGalleryLayout(galleryCollectionView: sut)

        let itemsWithFavorites = getItems(isFavorite: true)
        sut.setupDataSource(items: itemsWithFavorites)

        wait(for: Constants.Utils.sleep)

        verify(sut)
    }

    func testShouldFactoryGalleryCollectionView() {
        let sut = GridGalleryCollectionViewFactory.make(itemSize: itemSize, items: getItems())
        addGridGalleryLayout(galleryCollectionView: sut)

        wait(for: Constants.Utils.sleep)

        verify(sut)
    }

    // MARK: - Private functions

    private func addGridGalleryLayout(galleryCollectionView: GridGalleryCollectionView) {
        let sutViewController = addSubviewForTest(galleryCollectionView) { (viewController: UIViewController) -> [NSLayoutConstraint] in
            [
                galleryCollectionView.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor),
                galleryCollectionView.leadingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leadingAnchor),
                galleryCollectionView.trailingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.trailingAnchor),
                galleryCollectionView.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor)
            ]
        }

        sutViewController.view.layoutIfNeeded()
    }

    private func getItems(isFavorite: Bool = false) -> [GridGalleryItemViewModel] {
        guard let moviesPopulariesResponse = MocksHelper.getMockedMoviesPopulariesResponse() else {
            return []
        }

        return moviesPopulariesResponse.moviesResponse.map { movieResponse -> GridGalleryItemViewModel in
            GridGalleryItemViewModel(imageURL: Constants.MovieNetwork.baseImageURL.appending(movieResponse.imageURL), title: movieResponse.title, isFavorite: isFavorite)
        }
    }
}
